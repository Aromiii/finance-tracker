import 'package:finance_tracker/database.dart';
import 'package:flutter/material.dart';

class MoneySummary extends StatelessWidget {
  const MoneySummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 113,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Color(0xFF737373),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 56,
            child: Container(
              width: 400,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    strokeAlign:
                    BorderSide.strokeAlignCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 160,
            top: 113.04,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(-1.57),
              child: Container(
                width: 113.04,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.50,
                      strokeAlign:
                      BorderSide.strokeAlignCenter,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            left: 15,
            top: 67,
            child: Text(
              'This month',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Francois One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Positioned(
            left: 15,
            top: 11,
            child: Text(
              'Total',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Francois One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 67,
            child: Text(
              '423.34€',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Francois One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 11,
            child: Text(
              "${db.money.value.toString()}€",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Francois One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}