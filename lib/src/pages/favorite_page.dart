import 'package:flutter/material.dart';
import 'package:food_gate/src/models/food_model.dart';
import 'package:food_gate/src/scoped-model/main_model.dart';
import 'package:food_gate/src/widgets/food_items_card.dart';
// import 'package:food_gate/src/widgets/small_button.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritePage extends StatefulWidget {
  // final MainModel model;
  // FavoritePage({this.model});
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // @override
  // void initState() {
  //   // : implement initState
  //   super.initState();
  //   widget.model.fetchFood();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        model.fetchFood();
        List<Food> food = model.food;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: RefreshIndicator(
            onRefresh: model.fetchFood,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: food.map((Food food) {
                return FoodItemsCard(
                    food.name, food.price.toString(), food.description);
              }).toList(),
            ),
          ),
        );
      }),
    );
  }
}
