import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jr_stores_app/Providers/Cart_Provider.dart';
import 'package:jr_stores_app/Views/CheckOut_View.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.green,
          title: Text("MyCart (${FlutterCart().cartItem.length} Items)"),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50))),
          actions: [
            IconButton(
                tooltip: "",
                icon: Icon(Icons.clear_all),
                onPressed: () {
                  Mycartservices.clearCart();
                  setState(() {});
                })
          ],
        ),
        body: ListView.separated(
          separatorBuilder: (_, i) {
            return Divider(
              height: 4,
            );
          },
          itemCount: FlutterCart().cartItem.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8),
                height: height * 0.15,
                width: width * 1,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    Container(
                      width: width * 0.270,
                      height: height * 0.15,
                      child: CachedNetworkImage(
                          imageUrl: FlutterCart().cartItem[index].uniqueCheck),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * 0.5,
                          child: Text(
                            FlutterCart().cartItem[index].productName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: width * 0.4,
                          child: Text(
                            "Price: ₹ " +
                                FlutterCart()
                                    .cartItem[index]
                                    .unitPrice
                                    .toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.remove_circle),
                                  onPressed: () {
                                    Mycartservices.decrease(index);
                                    setState(() {});
                                  }),
                              Text(FlutterCart()
                                  .cartItem[index]
                                  .quantity
                                  .toString()),
                              IconButton(
                                  icon: Icon(Icons.add_circle),
                                  onPressed: () {
                                    Mycartservices.icrease(index);
                                    setState(() {});
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Mycartservices.removeCart(index);
                          setState(() {});
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
          height: height * 0.15,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TotalAmount: ₹"
                " ${FlutterCart().getTotalAmount()}",
              ),
              Text("SubTotal: ₹" " ${FlutterCart().getTotalAmount()}"),
              // ignore: deprecated_member_use
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  elevation: 0.0,
                  color: Colors.amber,
                  onPressed: () {
                    if (FlutterCart().cartItem.length == 0) {
                      Fluttertoast.showToast(msg: "Add Item to Proceed");
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => PaymentScreen()));
                    }
                  },
                  child: Text(
                    "PLACE ORDER",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ));
  }
}
