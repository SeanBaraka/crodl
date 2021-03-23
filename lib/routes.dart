import 'package:crodl/screens/account_setup.dart';
import 'package:crodl/screens/dashboard_screen.dart';
import 'package:crodl/screens/login_screen.dart';
import 'package:crodl/screens/register_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  AccountSetup.routeName: (context) => AccountSetup(),
  DashBoardScreen.routeName: (context) => DashBoardScreen()
};
