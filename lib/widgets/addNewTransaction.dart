import 'package:flutter/material.dart';
import '../database.dart';

class AddNewTransaction extends StatelessWidget {
  AddNewTransaction({
    Key? key,
  }) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              db.addNewTransaction(_titleController.text, double.tryParse(_amountController.text) ?? 0.0);
            },
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