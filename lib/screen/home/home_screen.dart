import 'package:flutter/material.dart';
import 'package:flutter_brew/service/authentication_service.dart';

class HomeScreen extends StatelessWidget {
  final AuthenticationService authenticationService = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      appBar: AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.brown.shade400,
        elevation: 0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed:  () async => await authenticationService.signOut(),
          )
        ],
      ),
      body: Container(
        child: Text('home'),
      ),
    );
  }
}
