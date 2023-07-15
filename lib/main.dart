import 'package:finance_tracker/auth.dart';
import 'package:finance_tracker/firebase_options.dart';
import 'package:finance_tracker/widgets/addNewTransaction.dart';
import 'package:finance_tracker/widgets/lastFiveTransactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFF2D2D2D)),
        child: Stack(
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
            Positioned(
              left: 0,
              top: 0,
              child: Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 676,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: StreamBuilder<User?>(
                              stream: authService.user,
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
                          ),
                          const SizedBox(height: 10),
                          Container(
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
                                    '423,34€',
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
                                    '12 343,56€',
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
                          ),
                          const SizedBox(height: 10),
                          LastFiveTransactions(),
                          const SizedBox(height: 10),
                          AddNewTransaction(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                                authService.signOut();
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
                            SizedBox(
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
                          ],
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            authService.signInWithGoogle();
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
        ),
      )),
    );
  }
}
