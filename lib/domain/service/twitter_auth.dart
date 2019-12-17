import 'package:firebase_auth/firebase_auth.dart';

abstract class TwitterAuth {
  Future<void> handleSignOut();
  Future<bool> isSignIn();
}