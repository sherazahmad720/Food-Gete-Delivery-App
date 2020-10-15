import 'dart:convert';

import 'package:food_gate/src/enum/auth_mode.dart';
import 'package:food_gate/src/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserModel extends GetxController {
  User _authenticatedUser;
  bool _isLoading = false;
  List<User> _users = [];
  List<User> users = [];
  bool get isLoading {
    return _isLoading;
  }

  List<User> get user {
    return List.from(_users);
  }

  User get authenticatedUser {
    return _authenticatedUser;
  }

  Future<bool> addUserInfo(Map<String, dynamic> userInfo) async {
    _isLoading = true;
    update();
    try {
      final http.Response response = await http.post(
          "https://food-gate.firebaseio.com/users.json",
          body: json.encode(userInfo));
      print(response);
      final Map<String, dynamic> responseDate = json.decode(response.body);
      User userWithId = User(
          id: responseDate['id'],
          email: responseDate['email'],
          // firstName: responseDate['firstName'],
          // lastName: responseDate['lastName'],
          // phoneNumber: responseDate['phoneNumber'],
          userName: responseDate['userName'],
          userType: "Customer"
          // token: responseDate['token'],
          );
      _users.add(userWithId);
      // print(_foods[0].description);

      _isLoading = false;
      update();
      // fetchFood();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      update();
      return Future.value(false);
      // print("Connection Error $e");
    }
  }

  Future<Map<String, dynamic>> authenticate(
      String email, String password, String userName,
      {AuthMode authMode = AuthMode.Signin}) async {
    _isLoading = true;
    update();

    Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
    };

    String message;
    bool hasError = false;
    Map<String, dynamic> userInfo = {
      "email": email,
      "userName": userName,
      "userType": "Customer"
    };
    try {
      http.Response response;
      if (authMode == AuthMode.Signup) {
        response = await http.post(
            "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCPHX6scofVxMlHe7k-cfJPDuravpvWT0c",
            body: json.encode(authData),
            headers: {'Content-Type': 'application/json'});

        addUserInfo(userInfo);
      } else if (authMode == AuthMode.Signin) {
        response = await http.post(
            'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCPHX6scofVxMlHe7k-cfJPDuravpvWT0c',
            body: json.encode(authData),
            headers: {'Content-Type': 'application/json'});
      }

      Map<String, dynamic> responseBody = json.decode("${response.body}");

      if (responseBody.containsKey('idToken')) {
        _authenticatedUser = User(
            id: responseBody["localId"],
            email: responseBody["email"],
            token: responseBody["idToken"],
            userType: "customer");

        if (authMode == AuthMode.Signup) {
          message = "Sign up successfully";
        } else {
          message = "Sign in successfully";
        }
      } else {
        hasError = true;
        if (responseBody['error']['message'] == 'EMAIL_EXISTS') {
          message = "Email already exist";

          print("Email already exist");
        } else if (responseBody['error']['message'] == 'EMAIL_NOT_FOUND') {
          message = "Email does not exist";

          print("Email does not exist");
        } else if (responseBody['error']['message'] == 'INVALID_PASSWORD') {
          message = "password is incorrect";
        }
        ;
      }
//
//Get User Details
      Future fetchUsers() async {
        update();
        try {
          final http.Response response =
              await http.get("https://food-gate.firebaseio.com/users.json/");

          final Map<String, dynamic> fetchedData = json.decode(response.body);
          final List<User> userLists = [];
          fetchedData.forEach((String id, dynamic userData) {
            User userList = User(
              id: id,
              userName: userData["userName"],
              email: userData["email"],
              userType: userData["userType"],
            );
            userLists.add(userList);
          });
          users = userLists;
          _isLoading = false;

          update();
          return Future.value(true);
        } catch (error) {
          _isLoading = false;

          update();
          return Future.value(false);
        }
      }

//
      _isLoading = false;
      update();
      return {'message': message, "hasError": hasError};
    } catch (error) {
      print("The error signup $error");
      _isLoading = false;
      update();
      return {'message': "Failed to sign up", "hasError": !hasError};
    }
  }
}
