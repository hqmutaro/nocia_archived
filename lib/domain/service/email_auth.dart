import 'package:firebase_auth/firebase_auth.dart';

abstract class EmailAuth {
  Future<FirebaseUser> handleSignUp({String email, String password});

  Future<FirebaseUser> handleSignIn({String email, String password});

  Future<void> handleSignOut();
}