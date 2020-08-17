import 'dart:convert';

import 'package:food_gate/src/models/food_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:http/http.dart' as http;

class FoodModel extends Model {
  List<Food> _foods = [];
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  List<Food> get food {
    return List.from(_foods);
  }

  Future<bool> addFood(Food food) async {
    _isLoading = true;
    notifyListeners();
    try {
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

      _isLoading = false;
      notifyListeners();
      fetchFood();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
      // print("Connection Error $e");
    }
  }

  void fetchFood() {
    http.get("https://food-gate.firebaseio.com/foods.json")
        // .get("https://my-json-server.typicode.com/typicode/demo/posts")
        .then((http.Response response) {
      final List<Food> foodItems = [];
      // print("Fetching data ${response.body}");
      final Map<String, dynamic> fetchedData = json.decode(response.body);
      print(fetchedData);
      fetchedData.forEach((String id, dynamic foodData) {
        Food foodItem = Food(
            id: id,
            name: foodData["title"],
            category: foodData["category"],
            description: foodData["description"],
            discount: foodData["discount"],
            price: foodData["price"]);
        foodItems.add(foodItem);
      });
      _foods = foodItems;
      // print(foodItems);
      notifyListeners();
      // fetchedData.forEach((data) {
      //   Food food = Food(
      //       id: data["id"],
      //       category: data["category_Id"],
      //       name: data["title"],
      //       price: data["price"],
      //       discount: data["discount"],
      //       imagePath: data["image_path"],
      //       rating: data["rating"]);

      //   fetchedFoodItems.add(food);
      //   print("this should run on first$food");
      // });
      // _foods = fetchedFoodItems;
      // print("This should run on 2nd");
    });
  }
}
