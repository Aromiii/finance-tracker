import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewTransaction extends StatelessWidget {
  AddNewTransaction({
    Key? key,
  }) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void createDocument() async {
      String title = _titleController.text;
      double amount = double.tryParse(_amountController.text) ?? 0.0;

      User? user = await authService.user?.first;
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
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

    return Container(
      width: double.infinity,
      height: 195,
      padding: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFF737373),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              'New event',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Francois One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFF9F9E9E),
              contentPadding: EdgeInsets.only(
                top: 3,
                left: 10,
                right: 249,
                bottom: 3,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0.50),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: 'Title',
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Francois One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFF9F9E9E),
              contentPadding: EdgeInsets.only(
                top: 3,
                left: 10,
                right: 249,
                bottom: 3,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0.50),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: 'Amount',
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Francois One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: createDocument,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 3,
                left: 100,
                right: 110,
                bottom: 3,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Color(0xFF00B512),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Add event',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Francois One',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}