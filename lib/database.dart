import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'auth.dart';

class Transaction {
  String title;
  double amount;
  String desc = "";

  Transaction(this.title, this.amount, this.desc);
}

class Database {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  BehaviorSubject<double> totalMoney = BehaviorSubject<double>.seeded(0.0);
  BehaviorSubject<double> monthMoney = BehaviorSubject<double>.seeded(0.0);
  BehaviorSubject<List<Transaction>> transactions = BehaviorSubject<List<Transaction>>.seeded([]);

  Database() {
    auth.user?.listen((user) async {
      if (user != null) {
        Future.wait([
          fetchTransactions(),
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
      return Transaction(data['title'], data['amount'], data['desc']);
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
      currentList.add(Transaction(title, amount, desc));
      transactions.add(currentList);
    } catch (e) {
      print('Error creating document: $e');
    }
  }

  Future<void> getCurrentMoneyOfLastMonthTransactions(User user) async {
    final DateTime currentDate = DateTime.now();
    final DateTime thirtyDaysAgo = currentDate.subtract(
        const Duration(days: 30));

    final QuerySnapshot snapshot = await instance
        .collection("users")
        .doc(user.uid)
        .collection("transactions")
        .where('createdAt', isGreaterThanOrEqualTo: thirtyDaysAgo)
        .where('createdAt', isLessThanOrEqualTo: currentDate)
        .get();

    double sum = 0.0;
    for (var doc in snapshot.docs) {
      Map<String, dynamic>? docData = doc.data() as Map<String,
          dynamic>?; // Explicit casting to Map<String, dynamic>
      final amount = docData?["amount"] as num?;
      if (amount != null) {
        sum += amount.toDouble();
      }
    }

    // Round the "sum" to two decimal places
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
}

final Database db = Database();