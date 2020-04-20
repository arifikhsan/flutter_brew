import 'package:flutter/material.dart';
import 'package:flutter_brew/service/authentication_service.dart';

class SignInScreen extends StatefulWidget {
  final Function toggleView;

  const SignInScreen({Key key, this.toggleView}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
        title: Text('Sign In to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
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
                obscureText: true,
                validator: (value) => value.length < 6
                    ? 'Enter a password for 6+ chars long'
                    : null,
                onChanged: (value) {
                  setState(() => password = value);
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.pink.shade400,
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic resultOrNull = authenticationService.signInWithEmailAndPassword(email, password);
                    if (resultOrNull == null) {
                      setState(() {
                        error = 'Could not ign in with those credential';
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 20),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
