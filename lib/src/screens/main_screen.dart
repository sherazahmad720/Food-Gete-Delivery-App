// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:food_gate/src/admin/pages/add_food_items.dart';
import 'package:food_gate/src/pages/favorite_page.dart';
import 'package:food_gate/src/pages/order_page.dart';
import 'package:food_gate/src/pages/profile_page.dart';

import 'package:food_gate/src/scoped-model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
// pages
import '../pages/home_page.dart';

class MainScreen extends StatefulWidget {
  final MainModel model;
  MainScreen({this.model});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;
  List<Widget> pages;
  Widget currentPage;
  HomePage homePage;
  OrderPage orderPage;
  FavoritePage favoritePage;
  ProfilePage profilePage;
  @override
  void initState() {
    homePage = HomePage();
    orderPage = OrderPage();
    //NOTE for refresh indicator
    // favoritePage = FavoritePage(model: widget.model);
    favoritePage = FavoritePage();
    profilePage = ProfilePage();
    pages = [homePage, favoritePage, orderPage, profilePage];
    currentPage = homePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AddFoodItems()));
                },
                leading: Icon(Icons.list),
                title: Text(
                  "Add Food Items",
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentTabIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              setState(() {
                currentTabIndex = index;
                currentPage = pages[index];
              });
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text("Home")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore), title: Text("Explore")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), title: Text("Orders")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text("Profile")),
            ]),
        body: currentPage,
      ),
    );
  }
}
