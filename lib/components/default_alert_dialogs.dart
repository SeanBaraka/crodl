import 'package:crodl/constants/colors.dart';
import 'package:crodl/screens/login_screen.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) {
        return AlertDialog(
          title: Text("Access Denied", style: TextStyle(fontWeight: FontWeight.bold),),
          content: Container(
            height: MediaQuery.of(context).size.height *  .15,
            child: Column(
              children: [
                Text('Your access token has expired. Kindly login again', style: TextStyle(fontSize: 18),),
                Spacer(),
                TextButton(onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
                }, child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Login Here", style: TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.w600),),
                ))
              ],
            ),
          ),
        );
      }
  );
}