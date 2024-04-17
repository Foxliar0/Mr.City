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
  List<Map<String, dynamic>> requestData = []; // Add this line

  @override
  void initState() {
    super.initState();
    fetchRequestData(); // Add this line
  }

  Future<void> fetchRequestData() async {
    // Fetch data from Firestore
    final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;// Replace with the actual user ID
    final snapshot = await FirebaseFirestore.instance
        .collection('tbl_request')
        .where('user', isEqualTo: userId)
        .get();

    setState(() {
      requestData = snapshot.docs.map((doc) => doc.data()).toList();
    });
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(request['title']),
                subtitle: Text(request['description']),
              ),
              if (request['status'] == 1)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Reply: ${request['reply']}',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    ),
  );
}
}
