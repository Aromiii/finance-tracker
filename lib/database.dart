import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'auth.dart';

class Transaction {
  String title;
  double amount;
  String desc = "";
  DateTime createdAt;

  Transaction(this.title, this.amount, this.desc, this.createdAt);
}

class Database {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  BehaviorSubject<double> totalMoney = BehaviorSubject<double>.seeded(0.0);
  BehaviorSubject<double> monthMoney = BehaviorSubject<double>.seeded(0.0);
  BehaviorSubject<List<Transaction>> transactions = BehaviorSubject<
      List<Transaction>>.seeded([]);

  Database() {
    auth.user?.listen((user) async {
      if (user != null) {
        await fetchTransactions();
        Future.wait([
          getCurrentMoneyOfTransactions(user),
          getCurrentMoneyOfLastMonthTransactions(user),
        ]);
      }
    });
  }

  Future<void> fetchTransactions() async {
    String uid = "";

    if (auth.currentUser.valueOrNull == null) {
      User? user = await auth.user?.first;
      uid = user?.uid ?? "";
    } else {
      uid = auth.currentUser.value?.uid ?? "";
    }

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("transactions")
        .orderBy('createdAt', descending: true)
        .limit(5)
        .get();

    transactions.add(querySnapshot.docs.map<Transaction>((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Transaction(data['title'], data['amount'], data['desc'], data['createdAt'].toDate());
    }).toList());
  }

  void addNewTransaction(String title, double amount, String desc) async {
    if (title == "" || amount == 0) {
      print("values must me provided");
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser.value?.uid)
          .set({
        "money": FieldValue.increment(amount)
      }, SetOptions(merge: true));

      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser.value?.uid)
          .collection('transactions')
          .add({
        'title': title,
        'amount': amount,
        'desc': desc,
        "createdAt": DateTime.now()
      });

      List<Transaction> currentList = transactions.value;
      currentList.add(Transaction(title, amount, desc, DateTime.now()));
      transactions.add(currentList);

      getCurrentMoneyOfTransactions(auth.currentUser.value as User);
      getCurrentMoneyOfLastMonthTransactions(auth.currentUser.value as User);
    } catch (e) {
      print('Error creating document: $e');
    }
  }

  Future<void> getCurrentMoneyOfLastMonthTransactions(User user) async {
    final DateTime currentDate = DateTime.now();
    final DateTime thirtyDaysAgo = currentDate.subtract(
        const Duration(days: 30));

    double sum = 0.0;
    for (var transaction in transactions.value) {
      if (transaction.createdAt.isBefore(currentDate) && transaction.createdAt.isAfter(thirtyDaysAgo)) {
        sum += transaction.amount;
      }
    }

    sum = double.parse(sum.toStringAsFixed(2));
    monthMoney.add(sum);
  }


  Future<void> getCurrentMoneyOfTransactions(User user) async {
    final userDoc = await instance.collection("users").doc(user.uid).get();
    if (userDoc.exists) {
      final moneyValue = userDoc.data()?['money'] as double? ?? 0.0;
      totalMoney.add(double.parse(moneyValue.toStringAsFixed(2)));
    }
  }

  void reset() {
    totalMoney.add(0.0);
    monthMoney.add(0.0);
    transactions.add([]);
  }
}

final Database db = Database();