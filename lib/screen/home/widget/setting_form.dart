import 'package:flutter/material.dart';
import 'package:flutter_brew/style/decoration.dart';

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
            decoration: textInputDecoration,
            validator: (value) => value.isEmpty ? 'Please enter a name' : null,
            onChanged: (value) {
              setState(() {
                _currentName = value;
              });
            },
          ),
          SizedBox(height: 20),
          // dropdown
          DropdownButtonFormField(
            decoration: textInputDecoration,
            value: _currentSugars ?? '0',
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
            value: (_currentStrength ?? 100).toDouble(),
            activeColor: Colors.brown[(_currentStrength ?? 100)],
            inactiveColor: Colors.brown[(_currentStrength ?? 100)],
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
            onPressed: () {
              print(_currentName);
              print(_currentSugars);
              print(_currentStrength);
            },
          ),
        ],
      ),
    );
  }
}
