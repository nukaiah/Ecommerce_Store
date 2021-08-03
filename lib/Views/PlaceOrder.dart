import 'package:flutter/material.dart';

class PlaceOtrder extends StatefulWidget {
  @override
  _PlaceOtrderState createState() => _PlaceOtrderState();
}

class _PlaceOtrderState extends State<PlaceOtrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Place Order"),
      ),
      body: ListView(
        children: [
          Text("Select Delivery Type"),
          Container(
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
