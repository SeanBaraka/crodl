import 'package:crodl/constants/colors.dart';
import 'package:crodl/routes.dart';
import 'package:crodl/screens/dashboard_screen.dart';
import 'package:crodl/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sms/sms.dart';

String isRemembered;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  isRemembered = prefs.getString("remembered");

  print('who is remembered $isRemembered');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkIfLoggedIn();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crodl',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(fontFamily: 'Source Sans Pro', primaryColor: primaryColor),
      home: isRemembered == 'true' ? DashBoardScreen() : LoginScreen(),
      // initialRoute: isLoggedIn == true ? DashBoardScreen.routeName : LoginScreen.routeName,
      routes: routes,
    );
  }

  // void checkIfLoggedIn() async{
  //   var prefs = await SharedPreferences.getInstance();
  //   var rememberToken = prefs.getString('remembered');
  //
  //   if (rememberToken == 'true') {
  //     isLoggedIn = true;
  //   } else {
  //     isLoggedIn = false;
  //   }
  // }
}
