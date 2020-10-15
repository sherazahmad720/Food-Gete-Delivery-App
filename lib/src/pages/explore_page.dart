import 'package:flutter/material.dart';
import 'package:food_gate/src/admin/pages/add_food_items.dart';
import 'package:food_gate/src/scoped-model/food_model.dart';
import 'package:food_gate/src/widgets/food_items_card.dart';
import 'package:food_gate/src/widgets/show_dialoge.dart';
import 'package:get/get.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final foodController = Get.put(FoodModel());
  GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();
  @override
  void initState() {
    // : implement initState
    super.initState();
    foodController.fetchFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _explorePageScaffoldKey,
        backgroundColor: Colors.white,
        body: GetBuilder<FoodModel>(builder: (_) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: _.foods.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    final bool response =
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => AddFoodItems(
                                  food: _.food[index],
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
                    showLoadingIndicator(context, "Deleting Food Iteam...");
                    _
                        .deleteFood(_.food[index].id)
                        .then((bool response) => Navigator.of(context).pop());
                  },
                  child: FoodItemsCard(
                      _.food[index].name,
                      _.food[index].price.toString(),
                      _.food[index].description),
                );
              },

              // crossAxisAlignment: CrossAxisAlignment.start,
            ),
          );
        }));
  }
}
