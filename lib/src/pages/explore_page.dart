import 'package:flutter/material.dart';
import 'package:food_gate/src/models/food_model.dart';
import 'package:food_gate/src/scoped-model/main_model.dart';
import 'package:food_gate/src/widgets/food_items_card.dart';
// import 'package:food_gate/src/widgets/small_button.dart';
import 'package:scoped_model/scoped_model.dart';

class ExplorePage extends StatefulWidget {
  // final MainModel model;
  // ExplorePage({this.model});
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
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
          builder: (BuildContext sctx, Widget child, MainModel model) {
        model.fetchFood();
        // List<Food> food = model.food;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: RefreshIndicator(
            onRefresh: model.fetchFood,
            child: ListView.builder(
              itemCount: model.foodLength,
              itemBuilder: (BuildContext lctx, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: FoodItemsCard(
                      model.food[index].name,
                      model.food[index].price.toString(),
                      model.food[index].description),
                );
              },

              // crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        );
      }),
    );
  }
}
