import 'dart:convert';

import 'package:food_gate/src/models/food_model.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class FoodModel extends GetxController {
  List<Food> foods = [];
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  List<Food> get food {
    return List.from(foods);
  }

  int get foodLength {
    return foods.length;
  }

  Future<bool> addFood(Food food) async {
    _isLoading = true;
    update();
    try {
      // foods.add(food);
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
      foods.add(foodWithId);
      // print(foods[0].description);

      _isLoading = false;
      update();
      fetchFood();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      update();
      return Future.value(false);
      // print("Connection Error $e");
    }
  }

  Future fetchFood() async {
    _isLoading = true;
    update();
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
      foods = foodItems;
      _isLoading = false;

      update();
      return Future.value(true);
    } catch (error) {
      _isLoading = false;

      update();
      return Future.value(false);
    }
  }

  Future<bool> updateFood(Map<String, dynamic> foodData, foodId) async {
    _isLoading = true;
    update();
    Food theFood = getFoodById(foodId);
    int foodIndex = foods.indexOf(theFood);
    try {
      await http.put("https://food-gate.firebaseio.com/foods/${foodId}.json",
          body: json.encode(foodData));
      Food updateFoodItem = Food(
          id: foodId,
          name: foodData["title"],
          category: foodData["category"],
          discount: foodData["discount"],
          price: foodData["price"],
          description: foodData["description"]);
      foods[foodIndex] = updateFoodItem;
      _isLoading = false;
      update();
      return Future.value(true);
    } catch (error) {
      print("error is $error");
      _isLoading = false;
      update();
      return Future.value(false);
    }
  }

  Future<bool> deleteFood(String foodId) async {
    try {
      _isLoading = true;
      update();
      final http.Response response = await http
          .delete("https://food-gate.firebaseio.com/foods/${foodId}.json");
      //delet item from list
      foods.removeWhere((Food food) => food.id == foodId);
      _isLoading = false;
      update();
      return Future.value(true);
    } catch (error) {
      _isLoading = false;
      update();
      return Future.value(false);
    }
  }

  Food getFoodById(String foodId) {
    Food food2;
    for (int i = 0; i < foods.length; i++) {
      if (foods[i].id == foodId) {
        food2 = foods[i];
        print("foood 2 is $food2");
        print("_food is ${foods[i]}");
        break;
      }
    }
    return food2;
  }
}
