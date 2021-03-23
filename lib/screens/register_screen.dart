import 'package:crodl/components/default_button.dart';
import 'package:crodl/components/default_checkbox.dart';
import 'package:crodl/components/default_loader.dart';
import 'package:crodl/components/input_box.dart';
import 'package:crodl/components/link_label.dart';
import 'package:crodl/constants/colors.dart';
import 'package:crodl/screens/login_screen.dart';
import 'package:crodl/services/network_services.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "/register";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();

  final userNameController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordConfirmController = TextEditingController();

  bool isLoading, agreedTerms, matchingPasswords;

  String invalidRegistrationDetails;

  @override
  void initState() {
    // TODO: implement initState

    isLoading = false;
    agreedTerms = false;
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
                  flex: 7,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Your Account",
                          style: TextStyle(fontSize: 24, color: darkColor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CrodlInputBox(
                          controller: userNameController,
                          labelText: "Enter Your Username",
                          hintText: "johnmichie1021",
                          secureText: false,
                        ),
                        CrodlInputBox(
                          controller: emailController,
                          labelText: "Enter Your Email Address",
                          hintText: "johnmichie@crodl.com",
                          secureText: false,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CrodlInputBox(
                          controller: passwordController,
                          labelText: "Enter Your Password",
                          hintText: "Password",
                          secureText: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CrodlInputBox(
                          controller: passwordConfirmController,
                          labelText: "Confirm Your Password",
                          hintText: "Password Confirmation",
                          secureText: true,
                        ),
                        SizedBox(height: 10,),
                        CrodlCheckBox(value: agreedTerms,labelText: "By continuing, you agree with our terms\n and conditions governing the use of this \nsoftware", onCheck: (value) => setState(() {
                          agreedTerms = value;
                        }),),
                        SizedBox(
                          height: 20,
                        ),
                        invalidRegistrationDetails != null
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 15),
                                child: Text(
                                  invalidRegistrationDetails,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            : Container(),
                        CrodlDefaultButton(
                          text: "Create Account",
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            // a successful registration should only work if the passwords match.
                            if (passwordController.text == passwordConfirmController.text) {
                              var registerData = {
                                "email": emailController.text,
                                "username": userNameController.text,
                                "password": passwordController.text
                              };

                              var registerAttempt =
                              await userRegister(registerData);
                              if (registerAttempt['status'] == 201) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    LoginScreen.routeName, (route) => false);
                              } else {
                                setState(() {
                                  invalidRegistrationDetails =
                                  registerAttempt['message'];
                                  isLoading = false;
                                });
                              }
                            } else {
                              setState(() {
                                isLoading = false;
                                matchingPasswords = false;
                                invalidRegistrationDetails = "The set passwords do not match";
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CrodlLinkLabel(
                          labelText: "Already Registered ?",
                          linkText: "Login Here",
                          onPressed: () => {
                            Navigator.pushNamedAndRemoveUntil(context,
                                LoginScreen.routeName, (route) => false)
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
                  invalideKeysError: invalidRegistrationDetails,
                  height: invalidRegistrationDetails != null
                      ? MediaQuery.of(context).size.height * .8
                      : MediaQuery.of(context).size.height * .7,
                )
              : Container()
        ]),
      ),
    );
  }
}

