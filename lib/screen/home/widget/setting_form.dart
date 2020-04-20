import 'package:flutter/material.dart';
import 'package:flutter_brew/model/user.dart';
import 'package:flutter_brew/service/database_service.dart';
import 'package:flutter_brew/style/decoration.dart';
import 'package:flutter_brew/widget/loading.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value.isEmpty ? 'Please enter a name' : null,
                  onChanged: (value) {
                    setState(() {
                      _currentName = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentSugars = value;
                    });
                  },
                ),
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor:
                      Colors.brown[(_currentStrength ?? userData.strength)],
                  inactiveColor:
                      Colors.brown[(_currentStrength ?? userData.strength)],
                  onChanged: (double value) {
                    setState(() {
                      _currentStrength = value.round();
                    });
                  },
                ),
                // slider
                RaisedButton(
                  color: Colors.pink.shade400,
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength,
                      );
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
