import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nocia/domain/service/google_auth.dart';
import 'package:nocia/infrastructure/repository/firebase_user_info_repository.dart';
import 'package:nocia/infrastructure/service/firebase_auth.dart';

class ServiceGoogleAuth implements GoogleAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = instance();

  Future<FirebaseUser> handleSignIn() async{
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _firebaseAuth.signInWithCredential(credential)).user;
    var repository = FirebaseUserInfoRepository(user: user);
    await repository.setUpUserData(name: user.displayName);
    return user;
  }

  Future<void> handleSignOut() => _firebaseAuth.signOut();

  Future<bool> isSignIn() => _googleSignIn.isSignedIn();
}