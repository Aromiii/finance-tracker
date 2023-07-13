import 'package:finance_tracker/auth.dart';
import 'package:finance_tracker/firebase_options.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
                                    if (snapshot.hasData &&
                                        snapshot.data != null) {
                                      // Display the data from the stream
                                      return Text(
                                        'Welcome ${snapshot.data
                                            ?.displayName}',
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
                                        decoration: ShapeDecoration(
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
                                          decoration: ShapeDecoration(
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
                              Container(
                                width: double.infinity,
                                height: 244,
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
                                child: const Column(
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
                                    EventListElement(
                                      title: 'kissa', price: 'koira',),
                                    SizedBox(height: 5),
                                    EventListElement(
                                      title: 'kissa', price: 'koira',),
                                    SizedBox(height: 5),
                                    EventListElement(
                                      title: 'kissa', price: 'koira',),
                                    SizedBox(height: 5),
                                    EventListElement(
                                      title: 'kissa', price: 'koira',),
                                    SizedBox(height: 5),
                                    EventListElement(
                                      title: 'kissa', price: 'koira',),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
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
                                          borderRadius: BorderRadius.circular(
                                              15),
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
                                          borderRadius: BorderRadius.circular(
                                              15),
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
                                        // Handle button tap
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
                                            borderRadius: BorderRadius.circular(
                                                15),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                              ),
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
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0)),
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
                                          decoration:
                                          BoxDecoration(
                                              color: Color(0xFFD9D9D9)),
                                        ),
                                      ),
                                    ],
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
                                          decoration:
                                          BoxDecoration(
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
                            )
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
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
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Francois One',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              price,
              style: TextStyle(
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

