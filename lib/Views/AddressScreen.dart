import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          TextFormField(),
          TextFormField(),
          TextFormField(),
          TextFormField(),
          TextFormField(),
        ],
      )),
    );
  }
}
