// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:food_gate/src/admin/pages/add_food_items.dart';
import 'package:food_gate/src/pages/explore_page.dart';
import 'package:food_gate/src/pages/order_page.dart';
import 'package:food_gate/src/pages/profile_page.dart';

// pages
import '../pages/home_page.dart';

class MainScreen extends StatefulWidget {
  // final MainModel model;
  MainScreen();
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;
  List<Widget> pages;
  Widget currentPage;
  HomePage homePage;
  OrderPage orderPage;
  ExplorePage explorePage;
  ProfilePage profilePage;
  @override
  void initState() {
    homePage = HomePage();
    orderPage = OrderPage();
    //NOTE for refresh indicator
    // explorePage = ExplorePage(model: widget.model);
    explorePage = ExplorePage();
    profilePage = ProfilePage();
    pages = [homePage, explorePage, orderPage, profilePage];
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
          title: Text(
            currentTabIndex == 0
                ? "Food Gate App"
                : currentTabIndex == 1
                    ? "All Food Items"
                    : currentTabIndex == 2
                        ? "Orders"
                        : "Profile",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none,
                // size: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(onPressed: () {}, icon: _buildShopingCart())
          ],
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
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore), label: "Explore"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Orders"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ]),
        body: currentPage,
      ),
    );
  }

  Widget _buildShopingCart() {
    return Stack(
      children: [
        Icon(
          Icons.shopping_cart,
          // size: 30,
          color: Theme.of(context).primaryColor,
        ),
        Positioned(
          right: 0.0,
          top: 0.0,
          child: Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: Colors.red),
            child: Center(
              child: Text(
                "2",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
