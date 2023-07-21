import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              'New transaction',
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
            keyboardType:
                const TextInputType.numberWithOptions(signed: true, decimal: true, ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.-]')),
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF9F9E9E),
              contentPadding: const EdgeInsets.only(
                top: 3,
                left: 10,
                right: 249,
                bottom: 3,
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 0.50),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: 'Amount',
              labelStyle: const TextStyle(
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
              db.addNewTransaction(_titleController.text,
                  double.tryParse(_amountController.text) ?? 0.0);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 7,
                bottom: 7,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Color(0xFF00B512),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Add transaction',
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
