import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:nocia/infrastructure/repository/firestore_reference.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';
import 'package:nocia/presentation/app.dart';

void main() async{
  //await auth.FirebaseAuth.instance.signOut();
  runApp(App());
}