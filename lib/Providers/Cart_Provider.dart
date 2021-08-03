import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Mycartservices {
  static FlutterCart cart = FlutterCart();

  static void addCart(
      String id, String name, String image, int price, int qty) {
    cart.addToCart(
        productId: id,
        unitPrice: price,
        quantity: qty,
        uniqueCheck: image,
        productName: name);
    //Fluttertoast.showToast(msg: name + 'Added to cart sucessfully');
    onCartChanged();
  }

  static removeCart(int index) {
    cart.deleteItemFromCart(index);
    Fluttertoast.showToast(msg: "removed successfully");
    onCartChanged();
  }

  static icrease(int index) {
    if (cart.cartItem[index].quantity > 4) {
      Fluttertoast.showToast(msg: "Only  5 are  allowed");
      return;
    }
    cart.incrementItemToCart(index);
    onCartChanged();
  }

  static decrease(int index) {
    cart.decrementItemFromCart(index);
    Fluttertoast.showToast(msg: "Item removed!");
    onCartChanged();
  }

  static void clearCart() {
    cart.deleteAllCart();
    onCartChanged();
    Fluttertoast.showToast(msg: "Cart cleared");
  }

  static onCartChanged() async {
    // write
    String uid = FirebaseAuth.instance.currentUser.uid;
    var allItems = cart.cartItem
        .map((item) => {
              "id": item.productId,
              "name": item.productName,
              "image": item.uniqueCheck,
              "price": item.unitPrice,
              "qty": item.quantity,
            })
        .toList();

    FirebaseFirestore.instance
        .collection("UsersData")
        .doc(uid)
        .update({"cart": allItems});
  }

  static syncCart(Function updateState) {
    // read
    String uid = FirebaseAuth.instance.currentUser.uid;

    FirebaseFirestore.instance
        .collection("UsersData")
        .doc(uid)
        .get()
        .then((user) async {
      // Fetch cart from db
      if (!user.exists) return;
      var cartItems = user.data()['cart']; // All cart items
      if (cartItems != null && cartItems.isNotEmpty) {
        // When cart is not empty.
        cartItems.forEach((item) {
          addCart(item['id'], item['name'], item['image'], item['price'],
              item['qty']);
        });
        updateState();
      }
    });
  }
}
