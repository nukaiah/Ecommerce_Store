import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jr_stores_app/Authentication_Views/BackGround.dart';
import 'package:jr_stores_app/Authentication_Views/Login_View.dart';
import 'package:jr_stores_app/Views/Home_View.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  bool _obsecure = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BackGround(
          title: "SIGN UP",
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textinput(_usernamecontroller, "UserName", Icons.person,
                      (value) {
                    if (value.isEmpty) {
                      return "Username can not be empty";
                    }
                    if (value.length < 4) {
                      return "Username Should be 4 Characters";
                    }
                    return null;
                  }),
                  SizedBox(height: 10),
                  textinput(_emailcontroller, "email", Icons.email, (value) {
                    if (value.isEmpty) {
                      return "Email Can not be empty";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                        .hasMatch(value)) {
                      return "please enter a valid email";
                    } else {
                      return null;
                    }
                  }),
                  SizedBox(height: 10),
                  textinput(_phoneNumberController, "PhoneNumber", Icons.call,
                      (value) {
                    if (value.isEmpty) {
                      return "PhoneNumber can not be empty";
                    }
                    if (value.length < 10) {
                      return "Enter a valid PhoneNumber";
                    }
                    return null;
                  }),
                  SizedBox(height: 10),
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
                          icon: Icon(
                            _obsecure ? Icons.visibility : Icons.visibility_off,
                            color: Colors.indigo[200],
                          ),
                          onPressed: () {
                            setState(() {
                              _obsecure = !_obsecure;
                            });
                          },
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
                  // ignore: deprecated_member_use
                  _isLoading
                      ? Center(child: SpinKitCircle(color: Colors.green))
                      : Align(
                          alignment: Alignment.centerRight,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            elevation: 0,
                            onPressed: () {
                              getRegister();
                            },
                            child: Text(
                              "SIGN UP",
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
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                      child: Text("Already have an account?LogIn"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textinput(_controller, String hint, IconData icon, _validator) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Colors.black54,
      child: TextFormField(
        style: TextStyle(
          color: Colors.white,
        ),
        controller: _controller,
        validator: _validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          suffixIcon: Icon(
            icon,
            color: Colors.indigo[200],
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
      ),
    );
  }

  Future<void> getRegister() async {
    try {
      if (_formKey.currentState.validate()) {
        setState(() {
          _isLoading = true;
        });
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailcontroller.text.toString(),
                password: _passwordcontroller.text.toString())
            .then((cred) async {
          storeUserData();
          if (cred.user == null) {
            print('Not loggedin');
          } else {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("email", _emailcontroller.text.toString());
            prefs.setString("password", _passwordcontroller.text.toString());
            prefs.setString("username", _usernamecontroller.text.toString());
            print("LogedIn");
          }
          setState(() {
            _isLoading = false;
          });
          Fluttertoast.showToast(msg: "Registered Successfully");
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

  Future<void> storeUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    await fireStore.collection("UsersData").doc(uid).set({
      "email": _emailcontroller.text.toString(),
      "username": _usernamecontroller.text.toString(),
      'uid': uid,
      "phoneNumber": _phoneNumberController.text.toString(),
      "timeStamp": DateTime.now().toIso8601String(),
      "profile":
          "https://firebasestorage.googleapis.com/v0/b/jrstores-125bd.appspot.com/o/Default%2Fstore.jpg?alt=media&token=05ae15ac-cd72-4374-bd38-fe903b5068d3"
    });
  }
}
