import 'package:flutter/material.dart';
import 'package:food_gate/src/models/food_model.dart';
import 'package:food_gate/src/widgets/button.dart';

class FoodDetailsPage extends StatefulWidget {
  final Food food;
  FoodDetailsPage({this.food});
  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  TextEditingController amountController = TextEditingController();
  int amount = 1;
  var small_space = SizedBox(
    height: 10,
  );
  var medium_space = SizedBox(
    height: 20,
  );
  var large_space = SizedBox(
    height: 50,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Food Details",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/images/coffee.png")),
              medium_space,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.food.name,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text("${widget.food.price} Rs.",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor)),
                ],
              ),
              medium_space,
              Text("Description",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              small_space,
              Text(
                widget.food.description,
                textAlign: TextAlign.justify,
              ),
              medium_space,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        setState(() {
                          if (amount > 1) {
                            amount--;
                          }
                        });
                      }),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    amount.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed: () {
                        setState(() {
                          amount++;
                        });
                      })
                ],
              ),
              large_space,
              Button(
                buttonText: "Add to Cart",
              )
            ],
          ),
        ),
      ),
    );
  }
}
