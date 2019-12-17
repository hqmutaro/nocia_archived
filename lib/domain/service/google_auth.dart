import 'package:firebase_auth/firebase_auth.dart';

abstract class GoogleAuth {
  Future<FirebaseUser> handleSignIn();
  Future<void> handleSignOut();
  Future<bool> isSignIn();
}