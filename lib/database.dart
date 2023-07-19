import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'auth.dart';

class Database {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  BehaviorSubject<double> money = BehaviorSubject<double>.seeded(0.0);

  Database() {
    auth.user?.listen((event) async {
      if (event != null) {
        final userDoc = await instance.collection("users").doc(event.uid).get();
        if (userDoc.exists) {
          final moneyValue = userDoc.data()?['money'] as double?;
          if (moneyValue != null) {
            // Process the money value as a double
            // Do something with the 'moneyValue'
            money.add(moneyValue);
          }
        }
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
}

final Database db = Database();