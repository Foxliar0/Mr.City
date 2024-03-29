import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mr_city/editprofile.dart';
import 'package:mr_city/myplace.dart';
import 'package:mr_city/topbar.dart';

// ignore: camel_case_types
class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String name = 'Loging...';

  String email = 'Loding...';

  String contact = 'Loding...';

  String profileImageUrl = 'assets/anonymous..jpg';

  void getData() {
    final user = FirebaseAuth.instance.currentUser;

    final userId = user?.uid;
    print(userId);
    if (userId != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);

      userDoc.get().then((documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Exist');
          final userData = documentSnapshot.data();
          setState(() {
            name = userData?['name'] ?? 'Name Not Found';
            email = userData?['email'] ?? 'Email Not Found';
            contact = userData?['contact'] ?? 'Contact Not Found';

            if (userData?['profileImageUrl'] != null) {
              profileImageUrl = userData?['profileImageUrl'];
            }
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/asd.png',
                ),
                alignment: Alignment.bottomCenter,
                fit: BoxFit.fitWidth)),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                const Topbar(),
                const SizedBox(height: 25),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 75,
                            backgroundColor: Color.fromARGB(255, 0, 0, 0),
                            backgroundImage: AssetImage('assets/jinu.jpg'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                        child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        letterSpacing: 1.5,
                      ),
                    )),
                    Container(
                      padding: const EdgeInsets.all(75),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.phone_android_sharp),
                              const SizedBox(width: 30),
                              Text(contact),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(Icons.email),
                              const SizedBox(width: 30),
                              Text(email)
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                   Editprofile(),
                                            ));
                                      },
                                      child: const Text('Edit Profile')))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(child: ElevatedButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Myplace(),));
                              }, child: Text('My Place')))
                            ],
                          )
                        ],
                      ),
                    )
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
