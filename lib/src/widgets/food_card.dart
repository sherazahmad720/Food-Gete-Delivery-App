import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final int numberOfItems;
  FoodCard({this.categoryName, this.imagePath, this.numberOfItems});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
          child: Row(
            children: [
              Image(
                image: AssetImage(imagePath),
                height: 65,
                width: 65,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    categoryName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(numberOfItems.toString() + " Kinds")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
