import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mr_city/addplace.dart';
import 'package:mr_city/request.dart';
import 'package:mr_city/topbar.dart';

class MyRequest extends StatefulWidget {
  const MyRequest({super.key});

  @override
  State<MyRequest> createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  List<Map<String, dynamic>> requestData = [];

  @override
  void initState() {
    super.initState();
    fetchRequestData();
  }

  Future<void> fetchRequestData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      final snapshot = await FirebaseFirestore.instance
          .collection('request')
          .where('user_id', isEqualTo: userId)
          .get();
      setState(() {
        requestData = snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print("Error: $e");
    }
    print(requestData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/asdfg.jpg'),
            alignment: Alignment.bottomCenter,
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: requestData.length,
          itemBuilder: (context, index) {
            final request = requestData[index];
            return Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['request'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      request['reply'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}