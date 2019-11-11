import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:nocia/domain/service/twitter_auth.dart';
import 'package:nocia/infrastructure/repository/firebase_user_info_repository.dart';
import 'package:nocia/infrastructure/service/firebase_auth.dart';

class ServiceTwitterAuth implements TwitterAuth {
  final TwitterLogin _twitterLogin = TwitterLogin(
    consumerKey: "HIoAbZ7qXgepCVAU1b9VtXECI",
    consumerSecret: "wTul6NYXOqTazgbzOQ7K5GX4xONuFyznDACVdUC1yM2UTH72GW"
  );
  final FirebaseAuth _firebaseAuth = instance();

  Future<void> handleSignIn() async{
    final TwitterLoginResult result = await _twitterLogin.authorize();
    AuthCredential credential = TwitterAuthProvider.getCredential(
        authToken: result.session.token,
        authTokenSecret: result.session.secret
    );
    AuthResult signIn = await _firebaseAuth.signInWithCredential(credential);
    FirebaseUser user = signIn.user;
    var repository = FirebaseUserInfoRepository(user: user);
    await repository.setUpUserData(name: user.displayName);
  }

  Future<void> handleSignOut() => _twitterLogin.logOut();

  @override
  Future<bool> isSignIn() => _twitterLogin.isSessionActive;
}