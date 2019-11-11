import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  Future<FirebaseUser> getUser() async{
    var auth = FirebaseAuth.instance;
    var user = await auth.currentUser();
    return user;
  }

  Future<bool> isAuth() async{
    var user = await getUser();
    return user != null;
  }
}
