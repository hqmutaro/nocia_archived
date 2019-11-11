import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nocia/domain/service/email_auth.dart';
import 'package:nocia/domain/service/google_auth.dart';
import 'package:nocia/infrastructure/repository/firebase_user_info_repository.dart';
import 'package:nocia/infrastructure/service/firebase_auth.dart';

class ServiceEmailAuth implements EmailAuth {

  final FirebaseAuth _firebaseAuth = instance();

  Future<FirebaseUser> handleSignUp({String name, String email, String password}) async{
    try {
      final FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      )).user;
      var repository = FirebaseUserInfoRepository(user: user);
      await repository.setUpUserData(name: name);

      return user;
    }
    catch (e) {
      throw e;
    }
  }

  Future<FirebaseUser> handleSignIn({String email, String password}) async{
    final FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    )).user;
    return user;
  }

  Future<void> handleSignOut() => _firebaseAuth.signOut();

}