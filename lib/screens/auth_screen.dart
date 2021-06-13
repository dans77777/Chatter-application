import 'package:chatter/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(String email, String username, String password,
      bool isLogin, BuildContext ctx) async {
    AuthResult _authResult;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      await Firestore.instance
          .collection('users')
          .document(_authResult.user.uid)
          .setData({'email': email, 'username': username});
    } on PlatformException catch (err) {
      var msg = 'An error occured ! check credentials';
      if (err.message != null) {
        msg = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm, isLoading));
  }
}
