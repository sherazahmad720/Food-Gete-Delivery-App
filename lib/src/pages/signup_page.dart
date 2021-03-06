import 'package:flutter/material.dart';
import 'package:food_gate/src/enum/auth_mode.dart';
import 'package:food_gate/src/pages/signin_page.dart';
import 'package:food_gate/src/scoped-model/user_scoped_model.dart';
import 'package:food_gate/src/widgets/show_dialoge.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final signupController = Get.put(UserModel());
  bool _togleVisibility = true;
  // bool _togleConfirmVisibility = true;
  String _email;
  String _userName;
  String _password;
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
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
          hintText: "Email ",
          hintStyle: TextStyle(color: Color(0xffbdc2cb), fontSize: 18)),
    );
  }

  Widget _buildUserNameTextField() {
    return TextFormField(
      onSaved: (String userName) {
        _userName = userName.trim();
      },
      validator: (String userName) {
        String errorMessage;
        if (userName.isEmpty) {
          errorMessage = "Username Field is required";
        }
        return errorMessage;
      },
      decoration: InputDecoration(
          hintText: " User Name",
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

  // Widget _buildConfirmPasswordTextField() {
  //   return TextFormField(
  //     obscureText: _togleConfirmVisibility,
  //     decoration: InputDecoration(
  //         suffixIcon: IconButton(
  //             icon: _togleConfirmVisibility
  //                 ? Icon(Icons.visibility_off)
  //                 : Icon(Icons.visibility),
  //             onPressed: () {
  //               setState(() {
  //                 _togleConfirmVisibility = !_togleConfirmVisibility;
  //               });
  //             }),
  //         hintText: "Confirm Password",
  //         hintStyle: TextStyle(color: Color(0xffbdc2cb), fontSize: 18)),
  //     onSaved: (String value) {},
  //   );
  // }

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
                  "Sign Up",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildUserNameTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        _buildEmailTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        _buildPasswordTextField(),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // _buildConfirmPasswordTextField()
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                _buildSignUpButton(),
                Divider(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account?",
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
                            builder: (BuildContext context) => SigninPage()));
                      },
                      child: Text(
                        "Sign in",
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

  Widget _buildSignUpButton() {
    return GetBuilder(
      builder: (_) {
        return GestureDetector(
          onTap: () {
            onSubmit();
            showLoadingIndicator(context, "Signing up ....");
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blueAccent),
            child: Center(
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  void onSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("email is $_email, and password is $_password");

      signupController
          .authenticate(_email, _password, _userName, authMode: AuthMode.Signup)
          .then((final response) {
        // Navigator.of(context).pop();
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
