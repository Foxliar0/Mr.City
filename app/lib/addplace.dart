import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_city/topbar.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Addplace extends StatefulWidget {
  const Addplace({super.key});

  @override
  State<Addplace> createState() => _AddplaceState();
}

class _AddplaceState extends State<Addplace> {
  
  List<Map<String, dynamic>> district = [];
  List<Map<String, dynamic>> location = [];
  List<Map<String, dynamic>> type = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  XFile? _selectedImage;

  late ProgressDialog _progressDialog;

  Future<void> fetchDistrict() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await db.collection('District').get();

      List<Map<String, dynamic>> dist = querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                'District': doc['district'].toString(),
              })
          .toList();
      setState(() {
        district = dist;
      });
    } catch (e) {
      print('Error fetching department data: $e');
    }
  }

  Future<void> fetchLocation(String id) async {
    try {
      selectlocation = '';
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collection('Location')
          .where('district', isEqualTo: id)
          .get();
      List<Map<String, dynamic>> loc = querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                'Location': doc['location'].toString(),
              })
          .toList();
      setState(() {
        location = loc;
      });
    } catch (e) {
      print(e);
    }
  }

Future<void> fetchType() async {
    try {
       selecttype = '';
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await db.collection('Type').get();

      List<Map<String, dynamic>> typ = querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                'Type': doc['type'].toString(),
              })
          .toList();
      setState(() {
        type = typ;
      });
    } catch (e) {
      print('Error fetching type data: $e');
    }
  }

  Future<void> insertData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      final data = <String, dynamic>{
        'user id': userId,
        'location': selectlocation,
        'place': _placeController.text.trim(),
        'details': _detailsController.text,
        'status': 0,
        'type':selecttype,
      };
      print("data: $data ");
      db
          .collection('place')
          .add(data)
          .then((DocumentReference doc) => Fluttertoast.showToast(
                msg: 'Place Added Successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                textColor: Colors.white,
              ));
      await _uploadImage(userId!);
    } catch (e) {
      print("Error inserting data $e");
      Fluttertoast.showToast(
        msg: 'Failed',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  String selectdistrict = '';
  String selectlocation = '';
  String selecttype = '';

  @override
  void initState() {
    super.initState();
    fetchDistrict();
    fetchType();
    _progressDialog = ProgressDialog(context);
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/pch.jpg'),
          alignment: Alignment.bottomCenter,
          fit: BoxFit.fill,
        )),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Topbar(),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectdistrict.isNotEmpty ? selectdistrict : null,
                  decoration: InputDecoration(
                    label: const Text('District'),
                    hintText: 'Select District',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(
                            255, 0, 0, 0), // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(
                            255, 3, 3, 3), // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    fetchLocation(newValue!);
                    setState(() {
                      selectdistrict = newValue;
                    });
                  },
                  isExpanded: true,
                  items: district.map<DropdownMenuItem<String>>(
                    (Map<String, dynamic> dist) {
                      return DropdownMenuItem<String>(
                        value: dist['id'],
                        child: Text(dist['District']),
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  value: selectlocation.isNotEmpty ? selectlocation : null,
                  decoration: InputDecoration(
                    label: const Text('Location'),
                    hintText: 'Select Location',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(
                            255, 0, 0, 0), // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(
                            255, 0, 0, 0), // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectlocation = newValue!;
                    });
                  },
                  isExpanded: true,
                  items: location.map<DropdownMenuItem<String>>(
                    (Map<String, dynamic> place) {
                      return DropdownMenuItem<String>(
                        value: place['id'],
                        child: Text(place['Location']),
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  value: selecttype.isNotEmpty ? selecttype : null,
                  decoration: InputDecoration(
                    label: const Text('Type'),
                    hintText: 'Select Type',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 18, 18, 18),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(
                            255, 0, 0, 0), // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(
                            255, 0, 0, 0), // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      
                      selecttype = newValue!;
                    });
                  },
                  isExpanded: true,
                  items: type.map<DropdownMenuItem<String>>(
                    (Map<String, dynamic> typ) {
                      return DropdownMenuItem<String>(
                        value: typ['id'],
                        child: Text(typ['Type']),
                      );
                    },
                  ).toList(),
                ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: _placeController,
                  decoration: const InputDecoration(
                      hintMaxLines: 20,
                      filled: true,
                      fillColor: Color.fromARGB(255, 139, 181, 203),
                      hintText: 'place',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 1, 1, 7))),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _detailsController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 139, 181, 203),
                      hintText: 'Details',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        insertData();
                      },
                      child: const Text('Sumbit'),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
