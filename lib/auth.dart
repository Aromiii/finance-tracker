import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class AuthService {
  // Shared State for Widgets
  Stream<User?>? user; // firebase user
  BehaviorSubject<User?> currentUser = BehaviorSubject<User?>(); // Represents the current user
  BehaviorSubject<bool> loading = BehaviorSubject<bool>();

  // Constructor
  AuthService() {
    user = FirebaseAuth.instance.authStateChanges();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      currentUser.add(user); // Update the currentUser BehaviorSubject with the received user
    });
  }

  Future<User?> signInWithGoogle() async {
    loading.add(true);

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    loading.add(false);
    return userCredential.user;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}

final AuthService authService = AuthService();
