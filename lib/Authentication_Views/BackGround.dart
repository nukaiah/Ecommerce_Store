import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class BackGround extends StatelessWidget {
  final Widget child;
  final String title;
  const BackGround({Key key, @required this.child, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 1,
      height: height * 1,
      child: Stack(
        children: [
          Positioned(
            left: width * 0.1,
            bottom: height * 0.8,
            child: Shimmer.fromColors(
                child: Text(
                  title,
                  style: GoogleFonts.dancingScript(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                ),
                baseColor: Colors.black,
                highlightColor: Colors.pinkAccent),
          ),
          Positioned(
            child: Image.asset(
              "assets/images/top1.png",
              fit: BoxFit.fill,
            ),
            top: 0,
            right: 0,
          ),
          Positioned(
            child: Image.asset("assets/images/top2.png", fit: BoxFit.fill),
            top: 0,
            right: 0,
          ),
          Positioned(
            child: Image.asset("assets/images/bottom1.png", fit: BoxFit.fill),
            bottom: 0,
            right: 0,
          ),
          Positioned(
            child: Image.asset("assets/images/bottom2.png", fit: BoxFit.fill),
            bottom: 0,
            right: 0,
          ),
          child
        ],
      ),
    );
  }
}
