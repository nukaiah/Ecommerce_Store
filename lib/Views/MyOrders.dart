import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jr_stores_app/Views/OrderPros.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser.uid.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.indigo[400],
        brightness: Brightness.dark,
        title: Text("MyOrders"),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(25))),
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection("Orders")
            .where("uid", isEqualTo: uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      snapshot.data.docs[index]["OrderTime"],
                    ),
                    subtitle: Text(snapshot.data.docs[index]["payment"]),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OrderPros(
                                    oplist: snapshot.data.docs[index]
                                        ["Products"],
                                  )));
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
