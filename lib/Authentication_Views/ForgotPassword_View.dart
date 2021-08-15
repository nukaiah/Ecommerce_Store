import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jr_stores_app/Authentication_Views/BackGround.dart';
import 'package:jr_stores_app/Authentication_Views/Login_View.dart';

class ForgotpasswordScreen extends StatefulWidget {
  @override
  _ForgotpasswordScreenState createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BackGround(
          title: "Forgot password?",
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.black54,
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: _emailcontroller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Email Can not be empty";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                            .hasMatch(value)) {
                          return "please enter a valid email";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white),
                        suffixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _isLoading
                      ? Center(
                          child: SpinKitCircle(
                            color: Colors.green,
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            elevation: 0,
                            onPressed: () {
                              forgotPassword();
                            },
                            child: Text(
                              "Reset Password",
                              style: GoogleFonts.dancingScript(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            color: Colors.orange,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> forgotPassword() async {
    try {
      if (_formKey.currentState.validate()) {
        setState(() {
          _isLoading = true;
        });
        FirebaseAuth auth = FirebaseAuth.instance;
        await auth
            .sendPasswordResetEmail(email: _emailcontroller.text.toString())
            .then((value) {
          Fluttertoast.showToast(
              msg:
                  "Password Reset Link sent to your registered email Successfully");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false);
          setState(() {
            _isLoading = false;
          });
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
