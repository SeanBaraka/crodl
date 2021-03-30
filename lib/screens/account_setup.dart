import 'dart:convert';

import 'package:crodl/components/default_alert_dialogs.dart';
import 'package:crodl/components/default_button.dart';
import 'package:crodl/components/default_loader.dart';
import 'package:crodl/components/input_box.dart';
import 'package:crodl/constants/colors.dart';
import 'package:crodl/screens/dashboard_screen.dart';
import 'package:crodl/screens/login_screen.dart';
import 'package:crodl/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountSetup extends StatefulWidget {
  static String routeName = '/account_setup';

  @override
  _AccountSetupState createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  final secretController = new TextEditingController();

  final keyController = new TextEditingController();

  final exhangeNameController = new TextEditingController();

  bool isLoading, isTokenExpired;
  String invalideKeysError;

  @override
  void initState() {
    // TODO: implement initState

    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: true,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Image.asset(
                        'assets/images/crodl-logo.png',
                        width: 150,
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Setup your Account",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "First Create a Bybit account using the following link",
                          style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var url =
                              "https://www.bybit.com/en-US/?affiliate_id=12193&Bgroup_id=0&Bgroup_type=1";
                          launch(url);
                        },
                        child: Text(
                            "https://www.bybit.com/en-US/?affiliate_id=12193&Bgroup_id=0&Bgroup_type=1",
                            style: TextStyle(
                                fontSize: 18,
                                color: primaryColor,
                                decoration: TextDecoration.underline)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CrodlInputBox(
                        labelText: "Select Exchange",
                        hintText: "Bybit",
                        secureText: false,
                        readOnly: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CrodlInputBox(
                        controller: keyController,
                        labelText: "API KEY",
                        hintText: "- - - - - - - - - - - - - - - - - - -",
                        secureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CrodlInputBox(
                        controller: secretController,
                        labelText: "API SECRET",
                        hintText: "- - - - - - - - - - - - - - - - - - -",
                        secureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      invalideKeysError != null
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 15),
                              child: Text(
                                invalideKeysError,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          : Container(),
                      Container(
                          width: double.infinity,
                          child: CrodlDefaultButton(
                            text: "Start Trading",
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              var userData = {
                                "api_key": keyController.text,
                                "api_secret": secretController.text
                              };

                              var response = await apiKeySecretSetup(userData);

                              if (response['status'] == 201) {
                                var prefs = await SharedPreferences
                                    .getInstance(); // save the api and key to shared prefs. we have to do it....
                                prefs.setString(
                                    'apiKeys', jsonEncode(userData));

                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    DashBoardScreen.routeName,
                                    (route) => false);
                              } else if (response['status'] == 400) {
                                setState(() {
                                  invalideKeysError = response['message'];
                                  isLoading = false;
                                });
                              } else if (response['status'] == 401) {
                                showAlertDialog(context);
                              }
                            },
                          ))
                    ],
                  ),
                ),
              ),
              isLoading == true
                  ? CrodlLoaderComponent(
                      invalideKeysError: invalideKeysError,
                      height: invalideKeysError != null
                          ? MediaQuery.of(context).size.height * .9
                          : MediaQuery.of(context).size.height * .85,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }



}
