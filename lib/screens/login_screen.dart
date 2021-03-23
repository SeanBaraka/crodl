import 'package:crodl/components/default_button.dart';
import 'package:crodl/components/default_checkbox.dart';
import 'package:crodl/components/default_loader.dart';
import 'package:crodl/components/input_box.dart';
import 'package:crodl/components/link_label.dart';
import 'package:crodl/constants/colors.dart';
import 'package:crodl/screens/account_setup.dart';
import 'package:crodl/screens/dashboard_screen.dart';
import 'package:crodl/screens/register_screen.dart';
import 'package:crodl/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userEmailController = new TextEditingController();

  final passwrdController = new TextEditingController();

  bool isLoading, rememberMe;

  String invalidLoginCredentials;

  @override
  void initState() {
    // TODO: implement initState

    isLoading = false;
    rememberMe = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(alignment: Alignment.center, children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset('assets/images/crodl-logo.png'),
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Login",
                          style: TextStyle(fontSize: 24, color: darkColor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CrodlInputBox(
                          controller: userEmailController,
                          labelText: "Enter Your Email Address",
                          hintText: "johnmichie@crodl.com",
                          secureText: false,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CrodlInputBox(
                          controller: passwrdController,
                          labelText: "Enter Your Password",
                          hintText: "Password",
                          secureText: true,
                        ),
                        SizedBox(height: 20,),
                        CrodlCheckBox(value: rememberMe,labelText: "Remember Me", onCheck: (value) => setState(() {
                          rememberMe = value;
                        }),),
                        SizedBox(
                          height: 20,
                        ),
                        invalidLoginCredentials != null
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 15),
                                child: Text(
                                  "Invalid Login Details",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            : Container(),
                        CrodlDefaultButton(
                          text: "Sign In",
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            var userLoginRequest = {
                              "email": userEmailController.text,
                              "password": passwrdController.text
                            };

                            var snapshot = await userLogin(userLoginRequest);

                            if (snapshot['status'] == 400) {
                              setState(() {
                                isLoading = false;
                                invalidLoginCredentials = snapshot['message'];
                              });
                            } else if (snapshot['status'] == 200) {
                              String token = snapshot["token"];

                              if (token != null) {
                                var sharedPrefs =
                                    await SharedPreferences.getInstance();

                                if(rememberMe == true) {
                                  sharedPrefs.setString('remembered', 'true');
                                }

                                sharedPrefs.setString('authToken', token);

                                var userKeys = sharedPrefs.getString('apiKeys');
                                if (userKeys != null) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      DashBoardScreen.routeName,
                                      (route) => false);
                                } else {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      AccountSetup.routeName, (route) => false);
                                }
                              } else {
                                print("Somemthing went wrong, try again");
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CrodlLinkLabel(
                          labelText: "Don't have an account ?",
                          linkText: "Register Here",
                          onPressed: () => {
                            Navigator.pushNamedAndRemoveUntil(context,
                                RegisterScreen.routeName, (route) => true)
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading == true
              ? CrodlLoaderComponent(
                  invalideKeysError: invalidLoginCredentials,
                  height: invalidLoginCredentials != null
                      ? MediaQuery.of(context).size.height * .8
                      : MediaQuery.of(context).size.height * .7,
                )
              : Container()
        ]),
      ),
    );
  }
}
