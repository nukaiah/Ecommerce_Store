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
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text("Select Delivery Type"),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.indigo[400])),
          ),
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
