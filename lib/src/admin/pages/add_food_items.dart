import 'package:flutter/material.dart';
import 'package:food_gate/src/models/food_model.dart';
import 'package:food_gate/src/scoped-model/main_model.dart';
import 'package:food_gate/src/widgets/button.dart';
import 'package:food_gate/src/widgets/show_dialoge.dart';
import 'package:scoped_model/scoped_model.dart';

class AddFoodItems extends StatefulWidget {
  final Food food;
  AddFoodItems({this.food});
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
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop(false);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                }),
            title: Text(
                widget.food != null ? "Update Food Items" : "Add Food Items",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          key: _scaffoldStateKey,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
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
                                image:
                                    AssetImage("assets/images/no_image.png")))),
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
                          onSubmit(model.addFood, model.updateFood);

                          if (model.isLoading) {
                            showLoadingIndicator(
                                context,
                                widget.food != null
                                    ? "Updating Food..."
                                    : "Adding Food...");
                          }
                        },
                        child: Button(
                          buttonText: widget.food != null
                              ? "Update Food Items"
                              : "Add Food Iteam",
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(Function addFood, Function updateFood) async {
    if (__foodItemFormKey.currentState.validate()) {
      __foodItemFormKey.currentState.save();
      if (widget.food != null) {
        //here is update code
        Map<String, dynamic> updatedFoodIteam = {
          "title": title,
          "category": category,
          "description": description,
          "price": double.parse(price),
          "discount": discount != null ? double.parse(discount) : 0.0,
          // "id": widget.food.id,
        };
        final bool response =
            await updateFood(updatedFoodIteam, widget.food.id);
        if (response) {
          Navigator.of(context).pop(); //to remove dialog
          Navigator.of(context).pop(response); //to go previous page
        } else if (!response) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text(
              "Failed to Update",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          );
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        }
      } else if (widget.food == null) {
        final Food food = Food(
            name: title,
            category: category,
            description: description,
            discount: double.parse(discount),
            price: double.parse(price));
        var value = await addFood(food);
        if (value) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(
            content: Text("Food Iteam Added Successfully"),
          );
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        } else if (!value) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(
            content: Text("Food Iteam not Added!"),
          );
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        }
      }
    }
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      initialValue: widget.food != null && hint == "Food Title"
          ? widget.food.name
          : widget.food != null && hint == "Description"
              ? widget.food.description
              : widget.food != null && hint == "Category"
                  ? widget.food.category
                  : widget.food != null && hint == "Price"
                      ? widget.food.price.toString()
                      : widget.food != null && hint == "Discount"
                          ? widget.food.discount.toString()
                          : "",
      decoration: InputDecoration(hintText: "$hint"),
      maxLines: maxLine,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        // String error;
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
        // return "";
      },
      onSaved: (String value) {
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
