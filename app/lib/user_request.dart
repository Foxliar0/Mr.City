import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mr_city/addplace.dart';
import 'package:mr_city/request.dart';
import 'package:mr_city/topbar.dart';

class ViewEnquiriesPage extends StatefulWidget {
  final String placeId;

  const ViewEnquiriesPage({super.key, required this.placeId});

  @override
  _ViewEnquiriesPageState createState() => _ViewEnquiriesPageState();
}

class _ViewEnquiriesPageState extends State<ViewEnquiriesPage> {
  List<Map<String, dynamic>> enquiriesData = [];

  @override
  void initState() {
    super.initState();
    _fetchEnquiriesData();
    print(widget.placeId);
  }

  Future<void> _fetchEnquiriesData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> enquiriesSnapshot =
          await FirebaseFirestore.instance
              .collection('request')
              .where('place', isEqualTo: widget.placeId)
              .get();

      List<Map<String, dynamic>> enquiriesDetails = [];
      for (var doc in enquiriesSnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        enquiriesDetails.add(data);
      }
      setState(() {
        enquiriesData = enquiriesDetails;
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Enquiries'),
      ),
      body: ListView.builder(
        itemCount: enquiriesData.length,
        itemBuilder: (context, index) {
          final enquiry = enquiriesData[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Request: ${enquiry['request']}',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 20, 86, 80),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    if (enquiry['status'] == 1)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Reply: ${enquiry['reply']}',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    if (enquiry['status'] == 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Show the prompt box to enter the reply
                            _showReplyPrompt(enquiry['id']);
                          },
                          child: Text('Reply'),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showReplyPrompt(id) async {
    final replyController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter Reply'),
        content: TextField(
          controller: replyController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Type your reply here',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Update the reply and status in Firestore
              _replyToEnquiry(id, replyController.text);
              Navigator.of(context).pop();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> _replyToEnquiry(id, String reply) async {
    try {
      // Update the 'reply' and 'status' fields in Firestore
      await FirebaseFirestore.instance.collection('request').doc(id).update({
        'reply': reply,
        'status': 1,
      });

      // Refresh the enquiriesData list
      await _fetchEnquiriesData();
    } catch (e) {
      print(e);
    }
  }
}
