import 'package:flutter/material.dart';
import 'package:food_gate/src/pages/signin_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _togleVisibility = true;
  bool _togleConfirmVisibility = true;
  Widget _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
          hintText: "Email ",
          hintStyle: TextStyle(color: Color(0xffbdc2cb), fontSize: 18)),
    );
  }

  Widget _buildUserNameTextField() {
    return TextField(
      decoration: InputDecoration(
          hintText: " User Name",
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

  Widget _buildConfirmPasswordTextField() {
    return TextField(
      obscureText: _togleConfirmVisibility,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: _togleConfirmVisibility
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  _togleConfirmVisibility = !_togleConfirmVisibility;
                });
              }),
          hintText: "Confirm Password",
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
                      SizedBox(
                        height: 20,
                      ),
                      _buildConfirmPasswordTextField()
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
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
    );
  }
}
