import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mr_city/login.dart';
import 'package:mr_city/topbar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool passCheck = true;
  bool passCheche = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confcontrooller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;
  String? _imageUrl;
  late ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();
    _progressDialog = ProgressDialog(context);
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = XFile(pickedFile.path);
      });
    }
  }

  Future<void> _registerUser() async {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        _progressDialog.show();

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passController.text,
        );

        // ignore: unnecessary_null_comparison
        if (userCredential != null) {
          await _storeUserData(userCredential.user!.uid);
          Fluttertoast.showToast(
            msg: "Registration Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          _progressDialog.hide();
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    } catch (e) {
      _progressDialog.hide();
      Fluttertoast.showToast(
        msg: "Registration Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      print("Error registering user: $e");
      // Handle error, show message, or take appropriate action
    }
  }

  Future<void> _storeUserData(String userId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(userId).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _contactController.text,
        'password': _passController.text,
        // Add more fields as needed
      });

      await _uploadImage(userId);
    } catch (e) {
      print("Error storing user data: $e");
      // Handle error, show message or take appropriate action
    }
  }

  Future<void> _uploadImage(String userId) async {
    try {
      if (_selectedImage != null) {
        Reference ref =
            FirebaseStorage.instance.ref().child('user_images/$userId.jpg');
        UploadTask uploadTask = ref.putFile(File(_selectedImage!.path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

        String imageUrl = await taskSnapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'imageUrl': imageUrl,
        });
      }
    } catch (e) {
      print("Error uploading image: $e");
      // Handle error, show message or take appropriate action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/abc.jpg.webp'), fit: BoxFit.fill)),
          // width: double.infinity,
          // height: double.infinity,
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            const Topbar(),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: const Color(0xff4c505b),
                              backgroundImage: _selectedImage != null
                                  ? FileImage(File(_selectedImage!.path))
                                  : _imageUrl != null
                                      ? NetworkImage(_imageUrl!)
                                      : const AssetImage('assets/abc.jpg.webp')
                                          as ImageProvider,
                              child: _selectedImage == null && _imageUrl == null
                                  ? const Icon(
                                      Icons.add,
                                      size: 40,
                                      color: Color.fromARGB(255, 134, 134, 134),
                                    )
                                  : null,
                            ),
                            if (_selectedImage != null || _imageUrl != null)
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 139, 181, 203),
                                  radius: 18,
                                  child: Icon(
                                    Icons.edit,
                                    size: 18,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 139, 181, 203),
                          hintText: 'Username',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 248, 248, 251),
                              )),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide.none,
                          )),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 139, 181, 203),
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide.none,
                          )),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _contactController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 139, 181, 203),
                          hintText: 'Contact',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.phone,
                                color: Color.fromARGB(236, 255, 255, 255),
                              )),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          )),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 139, 181, 203),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passCheche = !passCheche;
                              });
                            },
                            child: Icon(
                              passCheche
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromARGB(255, 247, 247, 250),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide.none,
                          )),
                      obscureText: passCheche,
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _confcontrooller,
                      obscureText: passCheck,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 139, 181, 203),
                          hintText: 'Confirm Password',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passCheck = !passCheck;
                              });
                            },
                            child: Icon(
                              passCheck
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide.none,
                          )),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  _registerUser();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 18,
                                        letterSpacing: .8),
                                  ),
                                ))),
                      ],
                    )
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}
