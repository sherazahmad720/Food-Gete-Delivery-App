import 'package:flutter/material.dart';

import 'package:food_gate/src/scoped-model/main_model.dart';
import 'package:food_gate/src/widgets/bought_food.dart';
import 'package:food_gate/src/widgets/food_category.dart';
import 'package:food_gate/src/widgets/home_top_info.dart';
import 'package:food_gate/src/widgets/search_field.dart';
import 'package:scoped_model/scoped_model.dart';
//data

//model
import '../models/food_model.dart';

class HomePage extends StatefulWidget {
  // final FoodModel foodModel;
  // HomePage(this.foodModel);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    print("This should run on third");

    super.initState();
  }

  // List<Food> _foods = foods;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20),
        children: [
          HomeTopInfo(),
          FoodCategory(),
          SizedBox(
            height: 20,
          ),
          SearchField(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Frequently Bought food",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              GestureDetector(
                onTap: () {},
                child: Text("View All",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.orangeAccent)),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            return Column(children: model.food.map(_buildFoodItems).toList());
          })
        ],
      ),
    );
  }

  Widget _buildFoodItems(Food food) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: BoughtFood(
        id: food.id,
        name: food.name,
        imagePath: food.imagePath,
        category: food.category,
        discount: food.discount.toString(),
        price: food.price.toString(),
        rating: food.rating.toString(),
      ),
    );
  }
}
