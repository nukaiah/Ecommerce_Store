import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jr_stores_app/Providers/Cart_Provider.dart';
import 'package:jr_stores_app/Providers/Product_Provider.dart';
import 'package:jr_stores_app/Views/Cart_View.dart';

class ViewAllScreen extends StatefulWidget {
  @override
  _ViewAllScreenState createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  @override
  void initState() {
    super.initState();
    FlutterCart().cartItem.length;

    Mycartservices.syncCart(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.green,
          title: Text("Exclusive Offers"),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50))),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CartScreen()));
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  iconSize: 30,
                ),
                Positioned(
                  right: -15,
                  left: 0,
                  top: 1,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text(
                        "${FlutterCart().cartItem.length}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        body: StreamBuilder(
          stream: DatabaseQuerys.featuredQuery.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SpinKitCircle(
                  color: Colors.green,
                ),
              );
            }
            return ListView.separated(
              separatorBuilder: (_, ii) => SizedBox(
                height: height * 0.01,
              ),
              itemCount: snapshot.data.docs.length,
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
                                imageUrl: snapshot.data.docs[index]
                                    ["imageUrl"]),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  width: width * 0.4,
                                  child: Text(
                                    snapshot.data.docs[index]["name"],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                width: width * 0.4,
                                child: Text(
                                  snapshot.data.docs[index]["qty"].toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                width: width * 0.4,
                                child: Text(
                                  "Price: ₹" +
                                      snapshot.data.docs[index]["price"]
                                          .toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Mycartservices.cart.getSpecificItemFromCart(
                                          snapshot.data.docs[index]["id"]) ==
                                      null
                                  // ignore: deprecated_member_use
                                  ? RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      color: Colors.green,
                                      elevation: 0.0,
                                      onPressed: () {
                                        String id =
                                            snapshot.data.docs[index]["id"];
                                        int price =
                                            snapshot.data.docs[index]["price"];
                                        int qty =
                                            snapshot.data.docs[index]["qty"];
                                        String name =
                                            snapshot.data.docs[index]["name"];
                                        String image = snapshot.data.docs[index]
                                            ["imageUrl"];
                                        setState(() {
                                          Mycartservices.addCart(
                                              id, name, image, price, qty);
                                        });
                                      },
                                      child: Text(
                                        "ADD TO CART",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  // ignore: deprecated_member_use
                                  : RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      color: Colors.indigo,
                                      elevation: 0.0,
                                      onPressed: () {},
                                      child: Text(
                                        "CHECK CART",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                            ],
                          )
                        ],
                      )),
                );
              },
            );
          },
        ));
  }
}
