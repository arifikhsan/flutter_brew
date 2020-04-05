import 'package:flutter/material.dart';
import 'package:flutter_brew/model/user.dart';
import 'package:flutter_brew/service/authentication_service.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthenticationService authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade400,
        elevation: 0,
        title: Text('Sign In to Brew Crew'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: RaisedButton(
          child: Text('Sign In Anonymously'),
          onPressed: () async {
            User result = await authenticationService.signInAnonymous();
            if (result == null) {
              print('error sign in');
            } else {
              print('signed in');
              print(result);
            }
          },
        ),
      ),
    );
  }
}
