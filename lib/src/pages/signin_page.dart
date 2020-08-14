import 'package:flutter/material.dart';
import 'package:food_gate/src/pages/signup_page.dart';
import 'package:food_gate/src/widgets/button.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool _togleVisibility = true;
  Widget _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
          hintText: "Your Email or User Name",
          hintStyle: TextStyle(color: Color(0xffbdc2cb), fontSize: 18)),
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
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
              Button(
                buttonText: "Login",
              ),
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
    );
  }
}
