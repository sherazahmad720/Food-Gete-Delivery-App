import 'package:flutter/material.dart';
import 'package:food_gate/src/models/food_model.dart';
import 'package:food_gate/src/scoped-model/main_model.dart';
import 'package:food_gate/src/widgets/button.dart';
import 'package:scoped_model/scoped_model.dart';

class AddFoodItems extends StatefulWidget {
  @override
  _AddFoodItemsState createState() => _AddFoodItemsState();
}

class _AddFoodItemsState extends State<AddFoodItems> {
  String title;
  String category;
  String description;
  String price;
  String discount;
  GlobalKey<FormState> __foodItemFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: __foodItemFormKey,
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width,
                    height: 170,
                    decoration: BoxDecoration(
                        // color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage("assets/images/no_image.png")))),
                _buildTextFormField("Food Title"),
                _buildTextFormField("Category"),
                _buildTextFormField("Description", maxLine: 5),
                _buildTextFormField("Price"),
                _buildTextFormField("Discount"),
                SizedBox(
                  height: 50,
                ),
                ScopedModelDescendant(builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return GestureDetector(
                    onTap: () {
                      if (__foodItemFormKey.currentState.validate()) {
                        __foodItemFormKey.currentState.save();
                        final Food food = Food(
                            name: title,
                            category: category,
                            description: description,
                            discount: double.parse(discount),
                            price: double.parse(price));
                        model.addFood(food);
                      }
                    },
                    child: Button(
                      buttonText: "Add Food Iteam",
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      decoration: InputDecoration(hintText: "$hint"),
      maxLines: maxLine,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        // var errormsg = "";
        if (value.isEmpty && hint == "Food Title") {
          return "The Food Title is required";
        }
        if (value.isEmpty && hint == "Description") {
          return "Description Title is required";
        }
        if (value.isEmpty && hint == "Category") {
          return "Category is required";
        }
        if (value.isEmpty && hint == "Price") {
          return "Price Title is required";
        }
        // return errormsg;
      },
      onChanged: (String value) {
        if (hint == "Food Title") {
          title = value;
        }
        if (hint == "Category") {
          category = value;
        }
        if (hint == "Description") {
          description = value;
        }
        if (hint == "Price") {
          price = value;
        }
        if (hint == "Discount") {
          discount = value;
        }
      },
    );
  }
}
