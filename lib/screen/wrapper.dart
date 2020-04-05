import 'package:flutter/material.dart';
import 'package:flutter_brew/model/user.dart';
import 'package:flutter_brew/screen/authentication/authentication_screen.dart';
import 'package:flutter_brew/screen/home/home_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return AuthenticationScreen();
    } else {
      return HomeScreen();
    }
  }
}
