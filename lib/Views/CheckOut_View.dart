import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:jr_stores_app/Providers/Remote_Config.dart';
import 'package:jr_stores_app/Views/AddressScreen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String radioItem = '';
  var _razorpay = Razorpay();
  var options;
  bool codenable = true;
  bool podenable = true;

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    options = {
      'key': 'rzp_test_2fNgmxneP6dNQE',
      'amount': 1 * 100,
      'name': 'Yalagala Srinivas',
      'description': 'Coffee Bill ',
      'prefill': {'contact': '8247467723', 'email': 'yskyadav0303@gmail.com'}
    };

    super.initState();
    testRConfig();
    testRConfig1();
  }

  testRConfig() async {
    RemoteConfig config = await MyConfigures.contro();
    setState(() => codenable = config.getString("COD") == "true");
  }

  testRConfig1() async {
    RemoteConfig config = await MyConfigures.contro();
    setState(() => podenable = config.getString("POD") == "true");
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds

    print("_handlePaymentSuccess payment is success ");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("_handlePaymentError payment is failed ");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Ordere"),
      ),
      body: Column(
        children: [
          Text("Delivery Address"),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddressScreen()));
            },
            child: Text("ADD ADDRESS+"),
          ),
          Text("Payment Method"),
          RadioListTile(
            groupValue: radioItem,
            title: Text('COD'),
            value: 'COD',
            onChanged: codenable
                ? (val) {
                    setState(() {
                      radioItem = val.toString();
                      print(radioItem);
                    });
                  }
                : null,
          ),
          Visibility(visible: !codenable, child: Text("COD Unavailable")),
          RadioListTile(
            groupValue: radioItem,
            title: Text('UPI'),
            value: 'UPI',
            onChanged: podenable
                ? (val) {
                    setState(() {
                      _razorpay.open(options);
                      radioItem = val.toString();
                      print(radioItem);
                    });
                  }
                : null,
          ),
          Visibility(visible: !podenable, child: Text("Payment Unavailable")),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.green,
        padding: EdgeInsets.all(20.0),
        height: height * 0.1,
        width: width * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payment Mode:" + "$radioItem",
              style: TextStyle(color: Colors.white),
            ),
            Container(
              color: Colors.black,
              child: TextButton(
                  onPressed: () {
                    print("order Placed");
                    // confirmOrder();
                  },
                  child: Text(
                    "Confirm Order",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

  // confirmOrder() {
  //   FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //   _fireStore.collection("Orders").doc().set({
  //     "Date": DateTime.now(),
  //     "Products": Mycartservices.cart.cartItem.map((e) {
  //       return {
  //         "proname": e.productName,
  //         "proimage": e.uniqueCheck,
  //       };
  //     })
  //   }).then((value) {
  //     Mycartservices.clearCart();
  //     Navigator.pushAndRemoveUntil(context,
  //         MaterialPageRoute(builder: (_) => CartScreen()), (route) => false);
  //   });
  // }
}
