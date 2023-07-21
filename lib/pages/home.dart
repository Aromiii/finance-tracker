import 'package:finance_tracker/pages/transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import '../widgets/addNewTransaction.dart';
import '../widgets/lastFiveTransactions.dart';
import '../widgets/moneySummary.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<User?>(
                    stream: auth.user,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        // Display the data from the stream
                        return Text(
                          'Welcome ${snapshot.data?.displayName}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Francois One',
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        // Handle stream error
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Show a loading indicator while waiting for data
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  const MoneySummary(),
                  const SizedBox(height: 10),
                  LastFiveTransactions(),
                  const SizedBox(height: 10),
                  AddNewTransaction(),
                ],
              ),
            )),
            Align(
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
                        padding: const EdgeInsets.symmetric(horizontal: 38),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(color: Color(0xFF737373)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                auth.signOut();
                              },
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFD9D9D9)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 160),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TransactionsPage()));
                              },
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFD9D9D9)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            auth.signInWithGoogle();
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
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}