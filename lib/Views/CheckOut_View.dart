import 'package:flutter/material.dart';
import 'package:jr_stores_app/Views/AddressScreen.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.green,
        title: Text("Place Your Order"),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))),
      ),
      body: Column(
        children: [
          Text("Delivery Address"),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddressScreen()));
            },
            child: Text("ADD ADDRESS+"),
          )
        ],
      ),
    );
  }
}
