import 'package:flutter/material.dart';
import 'package:flutter_brew/service/authentication_service.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggleView;

  const SignUpScreen({Key key, this.toggleView}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthenticationService authenticationService = AuthenticationService();
  final _formKey = GlobalKey<FormState>();

  // Text Field state
  String email = '';
  String password = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade400,
        elevation: 0,
        title: Text('Sign Up to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                validator: (value) => value.isEmpty ? 'Enter an email' : null,
                onChanged: (value) {
                  setState(() => email = value);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) =>
                    value.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (value) {
                  setState(() => password = value);
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.pink.shade400,
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic userOrNull = await authenticationService
                        .registerWithEmailAndPassword(
                      email,
                      password,
                    );
                    if (userOrNull == null) {
                      setState(() {
                        error = 'Please supply a valid email';
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 20),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
