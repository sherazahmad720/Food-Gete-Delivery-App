import 'package:flutter/material.dart';
import 'package:food_gate/src/widgets/small_button.dart';

class FoodItemsCard extends StatelessWidget {
  final String title;

  final String description;
  final String price;
  FoodItemsCard(this.title, this.price, this.description);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: 130,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 5, offset: Offset(0, 3), color: Colors.black12)
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(right: 10),
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage("assets/images/piza.jpg"),
                    fit: BoxFit.cover),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                child: Text(
                  "$description",
                  style: TextStyle(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("$price Rs.",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    SmallButton(
                      btnText: "Buy",
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
