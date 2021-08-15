import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();
  TextEditingController _vilageController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
        backgroundColor: Colors.indigo[400],
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              addinput(_usernameController, "Name", Icons.person, (value) {
                if (value.isEmpty) {
                  return "name can not be empty";
                }
                if (value.length < 4) {
                  return "Enter a valid name";
                }
                return null;
              }),
              SizedBox(height: 20),
              addinput(_phoneController, "Phone Number", Icons.call, (value) {
                if (value.isEmpty) {
                  return "Phone can not be empty";
                }
                if (value.length < 10) {
                  return "Enter a valid name";
                }
                return null;
              }),
              SizedBox(height: 20),
              addinput(_addressController, "Address", Icons.location_city,
                  (value) {
                if (value.isEmpty) {
                  return "Address can not be empty";
                }
                if (value.length < 2) {
                  return "Enter a valid address";
                }
                return null;
              }),
              SizedBox(height: 20),
              addinput(_landmarkController, "Landmark", Icons.location_on,
                  (value) {
                if (value.isEmpty) {
                  return "landmark can not be empty";
                }
                if (value.length < 4) {
                  return "Enter a valid landmark";
                }
                return null;
              }),
              SizedBox(height: 20),
              addinput(_vilageController, "City", Icons.location_city, (value) {
                if (value.isEmpty) {
                  return "name can not be empty";
                }
                if (value.length < 4) {
                  return "Enter a valid name";
                }
                return null;
              }),
              SizedBox(height: 20),
              // ignore: deprecated_member_use
              RaisedButton(
                color: Colors.indigo[400],
                child: Text("Save delivery Address",
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  print("Address");
                },
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget addinput(_controller, String hint, IconData icon, _validator) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(10)),
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
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}
