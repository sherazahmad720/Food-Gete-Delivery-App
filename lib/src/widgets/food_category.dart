import 'package:flutter/material.dart';
import 'package:food_gate/src/models/category_model.dart';
import 'package:food_gate/src/widgets/food_card.dart';
//data
import '../data/category_data.dart';
//Models
import '../models/category_model.dart';

class FoodCategory extends StatelessWidget {
  final List<Category> _categories = categories;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index) {
          return FoodCard(
            categoryName: _categories[index].categoryName,
            numberOfItems: _categories[index].numberOfItems,
            imagePath: _categories[index].imagePath,
          );
        },
      ),
    );
  }
}
