import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';
import 'package:nocia/infrastructure/service/service_email_auth.dart';
import 'package:nocia/infrastructure/service/service_google_auth.dart';
import 'package:nocia/infrastructure/service/service_twitter_auth.dart';
import 'package:nocia/presentation/home/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  bool isObscure = true;
  TextEditingController _name_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.isObscure = true;
  }
  
  @override
  Widget build(BuildContext context) {
    var name = getInputField(
      controller: _name_controller,
      hasIcon: false,
      label: "Name",
      hint: "新規",
      obscure: false,
    );
    var mail = getInputField(
      controller: _email_controller,
      hasIcon: false,
      label: "E-mail",
      hint: "",
      obscure: false,
    );
    var password = getInputField(
      controller: _password_controller,
      onPressed: () {
        setState(() {
          isObscure = !this.isObscure;
        });
      },
      hasIcon: true,
      hint: "",
      label: "Password",
      obscure: true,
      icon: Icon(
        Icons.visibility,
        color: Colors.white,
      ),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                name,
                mail,
                password,
                SizedBox(
                  height: 21,
                ),
              ],
            ),
            FlatButton(
              child: Text("新規登録"),
              onPressed: () async{
                var auth = ServiceEmailAuth();
                try {
                  var user = await auth.handleSignUp(
                      name: _name_controller.text,
                      email: _email_controller.text,
                      password: _password_controller.text
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                }
                catch (e) {
                  showDialog(context: context, builder: (_) {
                    return AlertDialog(
                      title: Text("ログインエラー", style: TextStyle(color: Colors.black),),
                      content: Text("このメールアドレスは既に使用されています", style: TextStyle(color: Colors.black)),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  });
                }
              },
            ),
            FlatButton(
              child: Text("ログイン"),
              onPressed: () async{
                var auth = ServiceEmailAuth();
                var user = await auth.handleSignIn(email: _email_controller.text, password: _password_controller.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            SignInButton(
              Buttons.Google,
              text: "Googleでサインイン",
              onPressed: () async{
                showLoader();
                var auth = ServiceGoogleAuth();
                var user = await auth.handleSignIn();
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            SignInButton(
              Buttons.Twitter,
              text: "Twitterでサインイン",
              onPressed: () async{
                try {
                  var auth = ServiceTwitterAuth();
                  await auth.handleSignIn();
                  var user = await UserRepository().getUser();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user)));
                }
                catch (e) {
                  throw e;
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void showLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              Text("Loading"),
            ],
          ),
        );
      },
    );
  }

  Widget getInputField({
    TextEditingController controller,
    String label,
    String hint,
    Function onPressed,
    bool obscure,
    bool hasIcon,
    Icon icon
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).textTheme.subhead,
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                  obscureText: obscure ? this.isObscure : false,
                ),
              ),
              hasIcon ? IconButton(
                icon: icon,
                onPressed: onPressed
              ) : Container(),
            ],
          ),
        ),
      ],
    );
  }
}