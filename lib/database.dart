import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'auth.dart';

class Database {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  BehaviorSubject<double> totalMoney = BehaviorSubject<double>.seeded(0.0);
  BehaviorSubject<double> monthMoney = BehaviorSubject<double>.seeded(0.0);



  Database() {
    auth.user?.listen((event) async {
      if (event != null) {
        await getCurrentMoneyOfTransactions(event);
        await getCurrentMoneyOfLastMonthTransactions(event);
      }
    });
  }

  void addNewTransaction(String title, double amount) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser.value?.uid)
          .update({
        "money": FieldValue.increment(amount)
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser.value?.uid)
          .collection('transactions')
          .add({
        'title': title,
        'amount': amount,
        "createdAt": DateTime.now()
      });
      print('Document created successfully!');
    } catch (e) {
      print('Error creating document: $e');
    }
  }

  Future<void> getCurrentMoneyOfLastMonthTransactions(User user) async {
    final DateTime currentDate = DateTime.now();
    final DateTime thirtyDaysAgo = currentDate.subtract(const Duration(days: 30));

    final QuerySnapshot snapshot = await instance
        .collection("users")
        .doc(user.uid)
        .collection("transactions")
        .where('createdAt', isGreaterThanOrEqualTo: thirtyDaysAgo)
        .where('createdAt', isLessThanOrEqualTo: currentDate)
        .get();

    double sum = 0.0;
    for (var doc in snapshot.docs) {
      Map<String, dynamic>? docData = doc.data() as Map<String, dynamic>?; // Explicit casting to Map<String, dynamic>
      final amount = docData?["amount"] as num?;
      if (amount != null) {
        sum += amount.toDouble();
      }
    }

    monthMoney.add(sum);
  }


  Future<void> getCurrentMoneyOfTransactions(User user) async {
    final userDoc = await instance.collection("users").doc(user.uid).get();
    if (userDoc.exists) {
      final moneyValue = userDoc.data()?['money'] as double?;
      if (moneyValue != null) {
        // Process the money value as a double
        // Do something with the 'moneyValue'
        totalMoney.add(moneyValue);
      }
    }
  }
}

final Database db = Database();