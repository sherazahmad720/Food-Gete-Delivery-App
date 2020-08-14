import 'dart:convert';

import 'package:food_gate/src/models/food_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:http/http.dart' as http;

class FoodModel extends Model {
  List<Food> _foods = [];
  List<Food> get food {
    return List.from(_foods);
  }

  void addFood(Food food) async {
    // _foods.add(food);
    final Map<String, dynamic> foodData = {
      "title": food.name,
      "category": food.category,
      "description": food.description,
      "price": food.price,
      "discount": food.discount
    };
    final http.Response response = await http.post(
        "https://food-gate.firebaseio.com/foods.json",
        body: json.encode(foodData));
    print(response);
    final Map<String, dynamic> responseDate = json.decode(response.body);
    Food foodWithId = Food(
        id: responseDate["name"],
        name: food.name,
        category: food.category,
        description: food.description,
        price: food.price,
        discount: food.discount);
    _foods.add(foodWithId);
    print(_foods[0].description);
  }

  void fetchFood() {
    http.get("http://192.168.43.239/flutter_food_app/api/foods/getfoods.php")
        // .get("https://my-json-server.typicode.com/typicode/demo/posts")
        .then((http.Response response) {
      // print("Fetching data ${response.body}");
      final List fetchedData = json.decode(response.body);
      final List<Food> fetchedFoodItems = [];
      fetchedData.forEach((data) {
        Food food = Food(
            id: data["id"],
            category: data["category_Id"],
            name: data["title"],
            price: data["price"],
            discount: data["discount"],
            imagePath: data["image_path"],
            rating: data["rating"]);

        fetchedFoodItems.add(food);
        print("this should run on first$food");
      });
      _foods = fetchedFoodItems;
      print("This should run on 2nd");
    });
  }
}
