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

  int get foodLength {
    return _foods.length;
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
      // print(_foods[0].description);

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

  Future fetchFood() async {
    _isLoading = true;
    notifyListeners();
    try {
      final http.Response response =
          await http.get("https://food-gate.firebaseio.com/foods.json");

      final Map<String, dynamic> fetchedData = json.decode(response.body);
      final List<Food> foodItems = [];
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
      _isLoading = false;

      notifyListeners();
      return Future.value(true);
    } catch (error) {
      _isLoading = false;

      notifyListeners();
      return Future.value(false);
    }
  }
}
