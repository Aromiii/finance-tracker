import 'package:finance_tracker/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  List<Map<String, dynamic>> transactionData = [];

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  void fetchTransactions() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser.value?.uid)
          .collection('transactions')
          .get();

      List<Widget> transactions = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String title = data['title'];
        String amount = data['amount'].toString();

        return AllLastTransactionsListWidget(title: title, amount: amount);
      }).toList();

      setState(() {
        transactionData = querySnapshot.docs.map<Map<String, dynamic>>((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      body: Stack(
        children: [
          Positioned(
            left: -80,
            top: -132,
            child: Container(
              width: 342,
              height: 342,
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.55, -0.84),
                  end: Alignment(-0.55, 0.84),
                  colors: [Color(0xFF00B512), Color(0x0000B512)],
                ),
                shape: OvalBorder(),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              padding: const EdgeInsets.all(5),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Last transactions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Column(
                    children: transactionData.map((transaction) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: AllLastTransactionsListWidget(
                          title: transaction['title'],
                          amount: "${transaction['amount']}€",
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Navbar()
        ],
      ),
    );
  }
}

class AllLastTransactionsListWidget extends StatelessWidget {
  const AllLastTransactionsListWidget({
    required this.title,
    required this.amount,
  });

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Color(0xFF737373),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50),
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 139),
                Text(
                  amount,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  color: Color(0xFF565656),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              "Tässä on jotain turhaa jorinaa ennen kuin descit on oikea asia mikä on databasessa",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}