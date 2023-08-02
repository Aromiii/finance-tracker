import 'package:finance_tracker/pages/addPage.dart';
import 'package:finance_tracker/pages/homePage.dart';
import 'package:flutter/material.dart';

import '../pages/authPage.dart';
import '../pages/transactionsPage.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 117,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Color(0xFF737373)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Icon(
                              Icons.home,
                              color: Color(0xFF00B512),
                              size: 60,
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Add onTap function for the second container
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Icon(
                              Icons.moving,
                              color: Color(0xFF00B512),
                              size: 60,
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TransactionsPage()),
                            );
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Icon(
                              Icons.format_list_bulleted,
                              color: Color(0xFF00B512),
                              size: 60,
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthPage()),
                            );
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Icon(
                              Icons.person,
                              color: Color(0xFF00B512),
                              size: 60,
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPage()),
                    );
                  },
                  child: Container(
                    width: 75,
                    height: 75,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF00B512),
                      shape: OvalBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 75,
                    )
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
