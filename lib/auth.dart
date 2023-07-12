import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class AuthService {
  // Dependencies
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Shared State for Widgets
  Stream<User>? user; // firebase user
  BehaviorSubject loading = BehaviorSubject();

  // Constructor
  AuthService() {
    user = _auth.currentUser as Stream<User>?;
  }

  Future<User?> signInWithGoogle() async {
    loading.add(true);

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    print(userCredential.user);
    loading.add(false);
    return userCredential.user;
  }

  void signOut() {
    // Implement sign out logic here
  }
}


final AuthService authService = AuthService();