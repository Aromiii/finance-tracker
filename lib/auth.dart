import 'package:finance_tracker/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class AuthService {
  Stream<User?>? user;
  BehaviorSubject<User?> currentUser = BehaviorSubject<User?>();

  // Constructor
  AuthService() {
    user = FirebaseAuth.instance.authStateChanges();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      currentUser.add(user);
    });
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.user;
  }

  void signOut() {
    FirebaseAuth.instance.signOut().then((value) {
      currentUser.add(null);
      db.reset();
    });
  }
}

final AuthService auth = AuthService();
