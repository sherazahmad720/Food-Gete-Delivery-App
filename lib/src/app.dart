import 'package:flutter/material.dart';
import 'package:food_gate/src/admin/pages/add_food_items.dart';

import 'package:food_gate/src/scoped-model/main_model.dart';
// import 'package:food_gate/src/homescreen.dart';
import 'package:food_gate/src/screens/main_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class App extends StatelessWidget {
  final MainModel mainModel = MainModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Food Delivery App",
        theme: ThemeData(primaryColor: Colors.blueAccent),
        // home: MainScreen(model: mainModel),
        home: AddFoodItems(),
      ),
    );
  }
}
