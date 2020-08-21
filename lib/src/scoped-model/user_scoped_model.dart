import 'dart:convert';

import 'package:food_gate/src/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class UserModel extends Model {
  User _authenticatedUser;
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  User get authenticatedUser {
    return _authenticatedUser;
  }

  void authenticate(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
    };
    String message;
    try {
      http.Response response = await http.post(
          "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCPHX6scofVxMlHe7k-cfJPDuravpvWT0c",
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});
      print("the response of body ${response.body}");
      Map<String, dynamic> responsebody = json.decode(response.body);
      if (responsebody.containsKey('idToken')) {
        _authenticatedUser = User(
            email: responsebody["email"],
            id: responsebody["localId"],
            token: responsebody["idToken"],
            userType: "customer");

        print("Printing the user token : ${_authenticatedUser.token}");
      } else {
        if (responsebody['error']['message'] == 'EMAIL_EXISTS') {
          message = "Email already exist";
          print("Email already exist");
        }
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print("The error signup $error");
      _isLoading = false;
      notifyListeners();
    }
  }
}
