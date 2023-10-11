import 'package:finance_tracker/database.dart';
import 'package:flutter/material.dart';

class LastFiveTransactions extends StatelessWidget {
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
              'Last transactions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 5),
          StreamBuilder<List<Transaction>>(
            stream: db.transactions.stream,
            // Listen to changes in the BehaviorSubject
            initialData: db.transactions.value,
            // Set initial data
            builder: (context, snapshot) {
              if (snapshot.data != []) {
                List<Transaction> transactions =
                    snapshot.data as List<Transaction>;
                return Column(
                  children: transactions
                      .take(5)
                      .map(
                        (transaction) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 0),
                            child: EventListElement(
                                title: transaction.title,
                                price: "${transaction.amount}€")),
                      )
                      .toList(),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
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
