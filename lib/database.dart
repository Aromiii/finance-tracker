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

  BehaviorSubject<double> averageCost = BehaviorSubject<double>.seeded(0.0);
  BehaviorSubject<double> averageIncome = BehaviorSubject<double>.seeded(0.0);
  BehaviorSubject<double> averageTransaction = BehaviorSubject<double>.seeded(0.0);

  BehaviorSubject<List<Transaction>> transactions =
      BehaviorSubject<List<Transaction>>.seeded([]);

  Database() {
    auth.user?.listen((user) async {
      if (user != null) {
        await fetchTransactions();
        await Future.wait([
          calculateCurrentMoneyOfTransactions(user),
          calculateCurrentMoneyOfLastMonthTransactions(user),
          calculateAverageCostAndIncome(user),
        ]);
        await calculateAverageTransaction(user);
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
        .limit(100)
        .get();

    transactions.add(querySnapshot.docs.map<Transaction>((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Transaction(data['title'], data['amount'], data['desc'],
          data['createdAt'].toDate());
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
          .set(
              {"money": FieldValue.increment(amount)}, SetOptions(merge: true));

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

      calculateCurrentMoneyOfTransactions(auth.currentUser.value as User);
      calculateCurrentMoneyOfLastMonthTransactions(
          auth.currentUser.value as User);
      calculateAverageCostAndIncome(auth.currentUser.value as User);
    } catch (e) {
      print('Error creating document: $e');
    }
  }

  Future<void> calculateCurrentMoneyOfLastMonthTransactions(User user) async {
    final DateTime currentDate = DateTime.now();
    final DateTime thirtyDaysAgo =
        currentDate.subtract(const Duration(days: 30));

    double sum = 0.0;
    for (var transaction in transactions.value) {
      if (transaction.createdAt.isBefore(currentDate) &&
          transaction.createdAt.isAfter(thirtyDaysAgo)) {
        sum += transaction.amount;
      }
    }

    sum = double.parse(sum.toStringAsFixed(2));
    monthMoney.add(sum);
  }

  Future<void> calculateCurrentMoneyOfTransactions(User user) async {
    final userDoc = await instance.collection("users").doc(user.uid).get();
    if (userDoc.exists) {
      final moneyValue = userDoc.data()?['money'] as double? ?? 0.0;
      totalMoney.add(double.parse(moneyValue.toStringAsFixed(2)));
    }
  }

  Future<void> calculateAverageCostAndIncome(User user) async {
    int averageIncomeCounter = 0;
    int averageCostCounter = 0;

    double _averageIncome = 0.0;
    double _averageCost = 0.0;

    for (var transaction in transactions.value) {
      if (transaction.amount >= 0.0) {
        _averageIncome += transaction.amount;
        ++averageIncomeCounter;
      }
      if (transaction.amount < 0.0) {
        _averageCost += transaction.amount;
        ++averageCostCounter;
      }
    }

    _averageIncome /= averageIncomeCounter;
    _averageCost /= averageCostCounter;

    averageIncome.add(double.parse(_averageIncome.toStringAsFixed(2)));
    averageCost.add(double.parse(_averageCost.toStringAsFixed(2)));
  }

  calculateAverageTransaction(User user) {
    averageTransaction.add(double.parse((totalMoney.value / transactions.value.length).toStringAsFixed(2)));
  }

  void reset() {
    totalMoney.add(0.0);
    monthMoney.add(0.0);
    transactions.add([]);
  }
}

final Database db = Database();