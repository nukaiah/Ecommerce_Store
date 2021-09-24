import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OrderPros extends StatefulWidget {
  final List oplist;
  OrderPros({Key key, @required this.oplist}) : super(key: key);
  @override
  _OrderProsState createState() => _OrderProsState();
}

class _OrderProsState extends State<OrderPros> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.indigo[400],
        brightness: Brightness.dark,
        title: Text("Order Products"),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(25))),
      ),
      body: ListView.separated(
        separatorBuilder: (_, ii) => SizedBox(
          height: height * 0.01,
        ),
        itemCount: widget.oplist.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: Colors.black)),
                height: height * 0.2,
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: CachedNetworkImage(
                          imageUrl: widget.oplist[index]["proimage"]),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            width: width * 0.4,
                            child: Text(
                              widget.oplist[index]["proname"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Container(
                          width: width * 0.4,
                          child: Text(
                            widget.oplist[index]["proqty"].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: width * 0.4,
                          child: Text(
                            "Price: ₹" +
                                widget.oplist[index]["proprice"].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
