import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nocia/infrastructure/repository/firebase_timetable_repository.dart';
import 'package:nocia/infrastructure/service/service_email_auth.dart';
import 'package:nocia/infrastructure/service/service_google_auth.dart';
import 'package:nocia/infrastructure/service/service_twitter_auth.dart';

class User {
  final FirebaseUser firebaseUser;
  final String name;
  final String photoUrl;
  dynamic timetable;

  User({
    @required this.firebaseUser,
    @required this.name,
    @required this.photoUrl,
    @required this.timetable
  }):
      assert(firebaseUser != null),
      assert(name != null),
      assert(photoUrl != null),
      assert(timetable != null);

  Future<void> signOut() async{
    var email = ServiceEmailAuth();
    await email.handleSignOut();
    var google = ServiceGoogleAuth();
    await google.handleSignOut();
    var twitter = ServiceTwitterAuth();
    await twitter.handleSignOut();
  }

  Future<void> updateTimetable() async{
    var timetableRepository = FirebaseTimetableRepository(uid: firebaseUser.uid);
    this.timetable = await timetableRepository.lectureTimetables();
  }
}