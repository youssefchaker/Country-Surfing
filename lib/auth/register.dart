import 'package:test/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:test/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleview;

  Register({required this.toggleview});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  //form info
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String err = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        elevation: 0.0,
        title: Text('Register'),
        actions: <Widget>[
          ElevatedButton.icon(
            onPressed: () {
              widget.toggleview();
            },
            icon: Icon(Icons.person),
            label: Text("Sign in"),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blueGrey[800]!),
            ),
          ),
        ],
      ),
      //check if the page is loading or not if so display the loading screen
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              //form and form validation section
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val!.isEmpty ? "Please enter an email" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? "The password must at least be 6 characters long"
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[400],
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            //register a user with pass and email in firebase
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _auth.registerempass(email, password);
                            //if error remove loading widget and print error
                            if (result == null) {
                              setState(() {
                                loading = false;
                                err = 'Please supply a valid mail';
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Sucessfully Registered. Welcome')),
                              );
                            }
                          } else {}
                        }),
                    SizedBox(
                      height: 12.0,
                    ),
                    //reserved place to print the error message
                    Text(
                      err,
                      style: TextStyle(
                          color: Color.fromARGB(255, 186, 26, 26),
                          fontSize: 14.00),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
