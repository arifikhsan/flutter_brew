import 'package:flutter/material.dart';
import 'package:flutter_brew/model/user.dart';
import 'package:flutter_brew/screen/wrapper.dart';
import 'package:flutter_brew/service/authentication_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthenticationService().user,
      child: MaterialApp(
        title: 'Material App',
        home: Wrapper(),
      ),
    );
  }
}
