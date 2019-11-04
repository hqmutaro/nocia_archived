import 'package:firebase_database/firebase_database.dart';

DatabaseReference instance() =>
    FirebaseDatabase.instance.reference();