import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

const String serverApiUrl = "185.201.9.57:5000";

Future<dynamic> userRegister(Map<String, String> userData) async {
  var url = Uri.http("$serverApiUrl", "/v1/register");
  var requestBody = convert.jsonEncode(userData);
  var response = await http.post(
    url,
    body: requestBody,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print("response ${response.body}");
  return jsonDecode(response.body);
}

Future<dynamic> userLogin(Map<String, String> loginData) async {
  var url = Uri.http("$serverApiUrl", "/v1/login");
  var loginRequestBody = jsonEncode(loginData);

  var loginResponse = await http.post(url,
      body: loginRequestBody,
      headers: {'Content-Type': 'application/json; charset=UTF-8'});

  return jsonDecode(loginResponse.body);
}

Future<dynamic> apiKeySecretSetup(Map<String, String> userData) async {
  var url = Uri.http("$serverApiUrl", "/v1/api_data");
  var apiData = jsonEncode(userData);

  // before sending the data, we first need to fetch the auth token from local storage
  var prefs = await SharedPreferences.getInstance();
  var tokenString = prefs.getString("authToken");

  var response = await http.post(url, body: apiData, headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $tokenString'
  });

  if (response.statusCode == 500) {
    var serverError = "{'message': 'Network error, please try again'}";

    return jsonDecode(serverError);
  }
  return jsonDecode(response.body);
}

Future<dynamic> getLeaderPositions() async {
  // first get the token, it is needed for this operation.
  // I don't know why it's needed, just that it's needed
  var prefs =
      await SharedPreferences.getInstance(); // initializing shared preferences

  var token =
      prefs.getString('authToken'); // getting the token from shared preferences

  var requestUrl = Uri.http('$serverApiUrl', '/v1/leader_position');

  var response = await http.get(requestUrl, headers: {
    'Authorization': 'Bearer $token'
  }); // attempt to get the request

  if (response.statusCode != 200) {
    var serverError = '{"message": "Network Error, try again"}';
    return jsonDecode(serverError);
  } // check if a status code of 200 was not returned, implying that an error occurred.


  return jsonDecode(response
      .body); // if a 200 status code was returned, then we are good to go. bye.
}

Future<dynamic> copyLeaderPosition(Map<String, String> positionDetails) async {
  var prefs =
      await SharedPreferences.getInstance(); // initializing shared preferences

  var token =
      prefs.getString('authToken'); // getting the token from shared preferences

  var requestUrl = Uri.http('$serverApiUrl', '/v1/copy_trade');

  var response =
      await http.post(requestUrl, body: jsonEncode(positionDetails), headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  });

  return jsonDecode(response.body);
}

Future<dynamic> getCurrentPositions() async {
  var url = Uri.http(serverApiUrl, '/v1/follower_orders');

  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('authToken');

  var response = await http.post(url, headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  });

  return jsonDecode(response.body);
}
