import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jr_stores_app/Authentication_Views/BackGround.dart';
import 'package:jr_stores_app/Authentication_Views/ForgotPassword_View.dart';
import 'package:jr_stores_app/Authentication_Views/SigUpView.dart';
import 'package:jr_stores_app/Views/Home_View.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  bool _obsecure = true;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGround(
        title: "LOGIN",
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
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.black54,
                  child: TextFormField(
                    obscureText: _obsecure,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: _passwordcontroller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Password can not be empty";
                      }
                      if (value.length < 6) {
                        return "Password Should be 6 Characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        icon: Icon(_obsecure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obsecure = !_obsecure;
                          });
                        },
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ForgotpasswordScreen()));
                    },
                    child: Text("Forgot password?"),
                  ),
                ),
                // ignore: deprecated_member_use
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
                            login();
                          },
                          child: Text(
                            "LOGIN",
                            style: GoogleFonts.dancingScript(
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          ),
                          color: Colors.orange,
                        ),
                      ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegisterPage()));
                  },
                  child: Text("Do not have an account?Register here"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    try {
      if (_formKey.currentState.validate()) {
        setState(() {
          _isLoading = true;
        });
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailcontroller.text.toString(),
                password: _passwordcontroller.text.toString())
            .then((cred) async {
          if (cred.user == null) {
            print('Not loggedin');
          } else {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("email", _emailcontroller.text.toString());
            prefs.setString("password", _passwordcontroller.text.toString());
            print("loggedin");
          }
          setState(() {
            _isLoading = false;
          });
          Fluttertoast.showToast(msg: "Welcome Back!");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
              (route) => false);
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
