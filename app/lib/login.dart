// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mr_city/changepassword.dart';
import 'package:mr_city/editprofile.dart';
import 'package:mr_city/email.dart';
import 'package:mr_city/myprofile.dart';
import 'package:mr_city/registration.dart';
import 'package:mr_city/userdashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool passCheck = true;

  Future<void> _login(BuildContext context) async {
    print('Hai');
    if (_formKey.currentState!.validate()) {
      // _progressDialog.show();
      try {
        final FirebaseAuth auth = FirebaseAuth.instance;
        final UserCredential userCredential =
            await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passController.text.trim(),
        );
        if (userCredential.user != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => UserDashboard()));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.jpg'), fit: BoxFit.cover)),
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      'Explore The City',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontStyle: FontStyle.normal,
                        letterSpacing: 1.5,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 139, 181, 203),
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.email,
                                  color: Color.fromARGB(207, 255, 255, 255),
                                )),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: passCheck,
                          controller: _passController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 139, 181, 203),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 249, 249, 255)),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passCheck = !passCheck;
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Color.fromARGB(220, 255, 255, 255),
                                )),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    print('hai');
                                    _login(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text('Log in',
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(233, 0, 0, 0))),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(39),
                      child: Row(children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ));
                            },
                            child: (Text(
                              "Create Account",
                              style: TextStyle(
                                  color: Color.fromARGB(233, 0, 0, 0)),
                            ))),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangePass(),
                                  ));
                            },
                            child: (Text(
                              'Forget Password',
                              style: TextStyle(
                                  color: Color.fromARGB(233, 0, 0, 0)),
                            )))
                      ])),
                ]),
          ),
        ),
      ),
    ));
  }
}
