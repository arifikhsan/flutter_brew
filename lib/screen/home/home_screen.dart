import 'package:flutter/material.dart';
import 'package:flutter_brew/model/brew.dart';
import 'package:flutter_brew/screen/home/widget/brew_list.dart';
import 'package:flutter_brew/service/authentication_service.dart';
import 'package:flutter_brew/service/database_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final AuthenticationService authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: Text('bottom sheet'),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown.shade100,
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown.shade400,
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async => await authenticationService.signOut(),
            ),
            FlatButton.icon(
              label: Text('Settings'),
              icon: Icon(Icons.settings),
              onPressed: _showSettingsPanel,
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
