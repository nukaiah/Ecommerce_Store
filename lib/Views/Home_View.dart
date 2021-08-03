import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jr_stores_app/Authentication_Views/Login_View.dart';
import 'package:jr_stores_app/Providers/Cart_Provider.dart';
import 'package:jr_stores_app/Providers/Product_Provider.dart';
import 'package:jr_stores_app/Views/CarouselDetails_View.dart';
import 'package:jr_stores_app/Views/Cart_View.dart';
import 'package:jr_stores_app/Views/CatgoryProducts_View.dart';
import 'package:jr_stores_app/Views/Search_View.dart';
import 'package:jr_stores_app/Views/ViewAll_View.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    Mycartservices.syncCart(() {
      if (mounted) {
        setState(() {});
      }
    });

    FlutterCart().cartItem.length;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('UsersData')
                    .where("uid", isEqualTo: auth.currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (_, i) {
                      return UserAccountsDrawerHeader(
                          currentAccountPicture: CircleAvatar(),
                          accountName: Text(snapshot.data.docs[i]["username"]),
                          accountEmail: Text(snapshot.data.docs[i]["email"]));
                    },
                  );
                }),
            Card(
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.share),
                title: Text("Share"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.phone_android),
                title: Text("Contact Us"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Log Out"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  signOutUser();
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.green,
        title: Text("Your Store"),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () async {
                  await Navigator.push(
                      context, MaterialPageRoute(builder: (_) => CartScreen()));
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
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        children: [
          SizedBox(
            height: height * 0.15,
            width: width * 0.9,
            child: StreamBuilder(
              stream: DatabaseQuerys.carouselQuery.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.green,
                    ),
                  );
                }
                return CarouselSlider.builder(
                  slideIndicator: CircularSlideIndicator(
                    currentIndicatorColor: Colors.white,
                    indicatorBackgroundColor: Colors.black,
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                  unlimitedMode: true,
                  enableAutoSlider: true,
                  itemCount: snapshot.data.docs.length,
                  slideBuilder: (i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: InkWell(
                        onTap: () {
                          print(i);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CarouselDetailsScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data.docs[i]["bannerimage"],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Exclusive Offers :",
                  style: GoogleFonts.oswald(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5),
                ),
                Shimmer.fromColors(
                  child: TextButton(
                    onPressed: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ViewAllScreen()));
                      setState(() {});
                    },
                    child: Text("ViewAll>>"),
                  ),
                  baseColor: Colors.orange,
                  highlightColor: Colors.white,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            height: MediaQuery.of(context).size.height * 0.25,
            child: StreamBuilder(
              stream: DatabaseQuerys.featuredQuery.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.green,
                    ),
                  );
                }
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  separatorBuilder: (_, ii) => SizedBox(
                    width: 10,
                  ),
                  itemBuilder: (_, i) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      width: width * 0.42,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black, width: width * 0.0025),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: LayoutBuilder(
                        builder: (_, constraints) {
                          return Column(
                            children: [
                              Card(
                                elevation: 0.0,
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data.docs[i]["imageUrl"],
                                  height: constraints.maxHeight * 0.50,
                                  width: constraints.maxWidth * 0.9,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                snapshot.data.docs[i]["name"],
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Align(
                                  child: Text(
                                    snapshot.data.docs[i]["qty"].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  alignment: Alignment.centerLeft),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Price: ₹" +
                                          snapshot.data.docs[i]["price"]
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Mycartservices.cart.getSpecificItemFromCart(
                                                snapshot.data.docs[i]["id"]) ==
                                            null
                                        ? IconButton(
                                            icon: Icon(Icons.add_shopping_cart,
                                                color: Colors.green),
                                            onPressed: () {
                                              String id =
                                                  snapshot.data.docs[i]["id"];
                                              int price = snapshot.data.docs[i]
                                                  ["price"];
                                              int qty =
                                                  snapshot.data.docs[i]["qty"];
                                              String name =
                                                  snapshot.data.docs[i]["name"];
                                              String image = snapshot
                                                  .data.docs[i]["imageUrl"];

                                              setState(() {
                                                Mycartservices.addCart(id, name,
                                                    image, price, qty);
                                              });
                                            })
                                        : IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.check_box_rounded,
                                              color: Colors.green,
                                            ))
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "OUR CATEGORIES :",
              style: GoogleFonts.oswald(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5),
            ),
          ),
          StreamBuilder(
            stream: DatabaseQuerys.catQuery.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: SpinKitCircle(
                    color: Colors.green,
                  ),
                );
              }
              if (snapshot.hasData) {}
              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (_, i) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black, width: width * 0.0025),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: LayoutBuilder(
                      builder: (_, constraints) {
                        return InkWell(
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CategoryScreen(
                                          catname: snapshot.data.docs[i]
                                              ["catname"],
                                          catslug: snapshot.data.docs[i]
                                              ["catslug"],
                                        )));
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Column(
                            children: [
                              Card(
                                elevation: 0.0,
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data.docs[i]["catimage"],
                                  height: constraints.maxHeight * 0.70,
                                  width: constraints.maxWidth * 0.86,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                snapshot.data.docs[i]["catname"],
                                style: GoogleFonts.oswald(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (_) => SearchScreen()));
          if (mounted) {
            setState(() {});
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> signOutUser() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      auth.signOut();
      FlutterCart().deleteAllCart();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
      Fluttertoast.showToast(msg: "LogOut Successfully");
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
