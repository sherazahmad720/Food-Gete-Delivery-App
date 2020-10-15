import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  int amount = 1;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffd3d3d3), width: 2.0),
                  borderRadius: BorderRadius.circular(10)),
              height: 75,
              width: 45,
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          if (amount < 1) {
                            amount--;
                          }
                        });
                      },
                      child: Icon(Icons.keyboard_arrow_up,
                          color: Color(0xffd3d3d3))),
                  Text(
                    amount.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          amount++;
                        });
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xffd3d3d3),
                      ))
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/piza.jpg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 5.0,
                        offset: Offset(5, 5))
                  ]),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Piza ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("180 Rs.",
                    style: TextStyle(fontSize: 16, color: Colors.orangeAccent)),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 25,
                  width: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Row(
                          children: [
                            Text("Chicken",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text("x",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.cancel,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
