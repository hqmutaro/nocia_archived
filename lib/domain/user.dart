import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nocia/infrastructure/service/service_email_auth.dart';
import 'package:nocia/infrastructure/service/service_google_auth.dart';
import 'package:nocia/infrastructure/service/service_twitter_auth.dart';

class User {
  final FirebaseUser firebaseUser;
  final String name;
  final String mail;
  final String photoUrl;

  User({
    @required this.firebaseUser,
    @required this.name,
    @required this.mail,
    @required this.photoUrl
  }):
      assert(firebaseUser != null),
      assert(name != null),
      assert(mail != null),
      assert (photoUrl != null);

  Future<void> signOut() async{
    var email = ServiceEmailAuth();
    await email.handleSignOut();
    var google = ServiceGoogleAuth();
    await google.handleSignOut();
    var twitter = ServiceTwitterAuth();
    await twitter.handleSignOut();
  }
}