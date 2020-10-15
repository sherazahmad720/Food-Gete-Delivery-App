import 'package:flutter/material.dart';
import 'package:food_gate/src/pages/food_details_page.dart';
import 'package:food_gate/src/scoped-model/food_model.dart';

import 'package:food_gate/src/widgets/bought_food.dart';
import 'package:food_gate/src/widgets/food_category.dart';
import 'package:food_gate/src/widgets/home_top_info.dart';
import 'package:food_gate/src/widgets/search_field.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  // final FoodModel foodModel;
  // HomePage(this.foodModel);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.put(FoodModel());
  @override
  void initState() {
    print("This should run on third");

    super.initState();
    homeController.fetchFood();
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
          GetBuilder<FoodModel>(builder: (_) {
            // _.fetchFood();
            return Column(
                children: [for (var data in _.foods) _buildFoodItems(data)]);
          })
        ],
      ),
    );
  }

  _buildFoodItems(food) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return FoodDetailsPage(
            food: food,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: BoughtFood(
          id: food.id,
          name: food.name,
          imagePath: "assets/images/coffee.png",
          category: food.category,
          discount: food.discount.toString(),
          price: food.price.toString(),
          rating: food.rating.toString(),
        ),
      ),
    );
  }
}
