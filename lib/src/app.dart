import 'package:flutter/material.dart';
import 'package:food_gate/src/pages/signin_page.dart';
import 'package:get/get.dart';
// import 'package:food_gate/src/homescreen.dart';
import 'package:food_gate/src/screens/main_screen.dart';

class App extends StatelessWidget {
  // final MainModel mainModel = MainModel();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Food Delivery App",
      theme: ThemeData(primaryColor: Colors.blueAccent),
      // home: MainScreen(model: mainModel),
      // home: AddFoodItems(),
      //routes
      routes: {
        "/": (BuildContext) => SigninPage(),
        "/mainscreen": (BuildContext) => MainScreen()
      },
    );
  }
}
