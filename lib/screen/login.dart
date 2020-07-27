import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../shared.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) async {
    QuerySnapshot document =  await Firestore.instance.collection("ustadz").where('user', isEqualTo: data.name).where('pass', isEqualTo: data.password).getDocuments();
    return Future.delayed(loginTime).then((_) {
      if(document.documents.length == 0){
        return 'Email atau password salah';
      }
      SharedPreferencesHelper.setID(document.documents.first.documentID);
      return null;
    });
  }

  Future<String> _regUser(LoginData data) async {
    DocumentReference ref = await Firestore.instance.collection("ustadz")
        .add({
      'user': data.name,
      'pass': data.password
    });
    return 'berhasil';
  }


  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'ABSENSI',
//      logo: 'assets/images/ecorp-lightblue.png',
      onLogin: _authUser,
      onSignup: _regUser,
      onSubmitAnimationCompleted: (){
        // Save the user preference
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(),
        ));
      },messages: LoginMessages(
        usernameHint: 'Email',
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm',
        loginButton: 'MASUK',
        signupButton: 'DAFTAR',
        forgotPasswordButton: 'Forgot huh?',
        recoverPasswordButton: 'HELP ME',
        goBackButton: 'KEMBALI',
        confirmPasswordError: 'Not match!',
    ),
      theme: LoginTheme(
        primaryColor: Colors.teal,
        accentColor: Colors.deepOrange,
        errorColor: Colors.deepOrange,
        titleStyle: TextStyle(
          color: Colors.white,
          letterSpacing: 3,
          fontWeight: FontWeight.bold
        ),
      )
    );
  }
}
