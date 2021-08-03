import 'package:flutter/material.dart';

class CarouselDetailsScreen extends StatefulWidget {
  @override
  _CarouselDetailsScreenState createState() => _CarouselDetailsScreenState();
}

class _CarouselDetailsScreenState extends State<CarouselDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(child: Text("Will be Updated in very soon")),
      ),
    );
  }
}
