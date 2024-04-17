import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendRequest extends StatefulWidget {
  final String id;
  const SendRequest({Key? key, required this.id}) : super(key: key);

  @override
  State<SendRequest> createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  final TextEditingController _detailsController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/qwert.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 30),
              TextFormField(
                controller: _detailsController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 139, 181, 203),
                  hintText: 'Enter Details',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _sendRequest();
                },
                child: Text('Send Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendRequest() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;

      await _db.collection('request').add({
        'user_id': userId,
        'request': _detailsController.text,
        'status': 0, // Assuming status 0 for "waiting"
        'reply':"",
        'place':widget.id,
        // Add other fields as needed
      });

      // Clear the text field after sending
      _detailsController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Request sent successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      
    } catch (e) {
      print('Error sending request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending request. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
