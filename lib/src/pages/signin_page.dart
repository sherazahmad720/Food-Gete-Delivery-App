import 'package:flutter/material.dart';
import 'package:food_gate/src/enum/auth_mode.dart';
import 'package:food_gate/src/pages/signup_page.dart';

import 'package:food_gate/src/scoped-model/user_scoped_model.dart';
import 'package:food_gate/src/widgets/button.dart';
import 'package:food_gate/src/widgets/show_dialoge.dart';
import 'package:get/get.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final loginController = Get.put(UserModel());

  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String _email;
  String _password;
  bool _togleVisibility = true;
  Widget _buildEmailTextField() {
    return TextFormField(
      onSaved: (String email) {
        _email = email;
      },
      validator: (String email) {
        String errorMessage;
        if (!email.contains("@")) {
          errorMessage = "Email is not correct";
        }
        if (email.isEmpty) {
          errorMessage = "Email Field is required";
        }
        return errorMessage;
      },
      decoration: InputDecoration(
          hintText: "Your Email or User Name",
          hintStyle: TextStyle(color: Color(0xffbdc2cb), fontSize: 18)),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      onSaved: (String password) {
        _password = password;
      },
      validator: (String password) {
        String errorMessage;
        if (password.isEmpty) {
          errorMessage = "Password is Required";
        }
        return errorMessage;
      },
      obscureText: _togleVisibility,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: _togleVisibility
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  _togleVisibility = !_togleVisibility;
                });
              }),
          hintText: "Password",
          hintStyle: TextStyle(color: Color(0xffbdc2cb), fontSize: 18)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                ),
                Text(
                  "Sign In",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildEmailTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        _buildPasswordTextField()
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                _buildSignInButton(),
                Divider(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Color(0xffbdc2cb),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => SignupPage()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return GetBuilder(builder: (_) {
      return GestureDetector(
        onTap: () {
          showLoadingIndicator(context, "Signing in...");
          onSubmit();
        },
        child: Button(
          buttonText: "Login",
        ),
      );
    });
  }

  void onSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("Password $_password, email is $_email");

      loginController
          .authenticate(_email, _password, "", authMode: AuthMode.Signin)
          .then((final response) {
        if (!response["hasError"]) {
          // print(response["message"]);
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed("/mainscreen");
        } else {
          Navigator.of(context).pop();
          print(response["message"]);
          _scaffoldKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
              content: Text(response["message"])));
        }
      });
    }
  }
}
