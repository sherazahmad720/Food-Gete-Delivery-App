import 'package:flutter/material.dart';
import 'package:food_gate/src/admin/pages/add_food_items.dart';
// import 'package:food_gate/src/models/food_model.dart';
import 'package:food_gate/src/scoped-model/main_model.dart';
import 'package:food_gate/src/widgets/food_items_card.dart';
import 'package:food_gate/src/widgets/show_dialoge.dart';
// import 'package:food_gate/src/widgets/small_button.dart';
import 'package:scoped_model/scoped_model.dart';

class ExplorePage extends StatefulWidget {
  // final MainModel model;
  // ExplorePage({this.model});
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();
  // @override
  // void initState() {
  //   // : implement initState
  //   super.initState();
  //   widget.model.fetchFood();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _explorePageScaffoldKey,
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
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    final bool response =
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => AddFoodItems(
                                  food: model.food[index],
                                )));
                    if (response) {
                      SnackBar snackBar = SnackBar(
                        duration: Duration(seconds: 2),
                        backgroundColor: Theme.of(context).primaryColor,
                        content: Text(
                          "Update Successfully",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      );
                      _explorePageScaffoldKey.currentState
                          .showSnackBar(snackBar);
                    }
                  },
                  onLongPress: () {
                    //delete the food item
                    showLoadingIndicator(sctx, "Deleting Food Iteam...");
                    model
                        .deleteFood(model.food[index].id)
                        .then((bool response) => Navigator.of(context).pop());
                  },
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
