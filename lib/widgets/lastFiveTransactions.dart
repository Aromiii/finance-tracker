import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LastFiveTransactions extends StatefulWidget {
  @override
  _LastFiveTransactionsState createState() => _LastFiveTransactionsState();
}

class _LastFiveTransactionsState extends State<LastFiveTransactions> {
  List<Map<String, dynamic>> eventData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    User? user = await authService.user?.first;
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("transactions")
        .orderBy('createdAt', descending: true)
        .limit(5)
        .get();

    setState(() {
      eventData = querySnapshot.docs.map<Map<String, dynamic>>((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Color(0xFF737373),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: const [
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
          SizedBox(
            width: double.infinity,
            child: Text(
              'Last events',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Francois One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 5),
          Column(
            children: eventData.map((event) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 3.0),
                child: EventListElement(
                  title: event['title'],
                  price: "${event['amount']}€",
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class EventListElement extends StatelessWidget {
  final String title;
  final String price;

  const EventListElement({
    required this.title,
    required this.price,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      padding: const EdgeInsets.only(top: 3, left: 9, right: 7, bottom: 4),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFF737373),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        // Add horizontal padding
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Francois One',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              price,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Francois One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

