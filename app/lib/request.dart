import 'package:flutter/material.dart';
import 'package:mr_city/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_city/user_request.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  List<Map<String, dynamic>> placedata = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  void initState() {
    super.initState();
    _fetchPlaceData();
  }

  Future<void> _fetchPlaceData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;

      QuerySnapshot<Map<String, dynamic>> placeSnapshot = await db
          .collection('place')
          .where('user id', isEqualTo: userId)
          .get();

      List<Map<String, dynamic>> placedetails = [];
      for (var doc in placeSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['place'] = doc.id;
        data['details'] = doc["details"];
        data['status'] = doc["status"];

        DocumentSnapshot locationDoc =
            await db.collection('Location').doc(data['location']).get();
        if (locationDoc.exists) {
          Map<String, dynamic> locData =
              locationDoc.data() as Map<String, dynamic>;
          data['loc'] = locData["location"];
        }

        DocumentSnapshot typeDoc =
            await db.collection('Type').doc(data['type']).get();
        if (typeDoc.exists) {
          Map<String, dynamic> typeData =
              typeDoc.data() as Map<String, dynamic>;
          data['type'] = typeData["type"];
        }

        placedetails.add(data);
      }
      setState(() {
        placedata = placedetails;
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/qwert.jpg'), fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const Topbar(),
              SizedBox(height: 30),
             
              Container(
                padding: EdgeInsets.all(5),
                color: Colors.black
                    .withOpacity(0.0), // Adjust the opacity as needed
                child: placedata.isEmpty
                    ? Center(
                        child: Text('No place details found'),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: placedata.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final placeDetail = placedata[index];
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GestureDetector(
                              onTap: () {
                                // Handle onTap event if needed
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Place: ${placeDetail['place']}',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 20, 86, 80),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        'Details: ${placeDetail['details']}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Location: ${placeDetail['loc']}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Type: ${placeDetail['type']}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Status: ${_getPlaceStatus(placeDetail['status'])}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      if (placeDetail['status'] == 1)
                                        ElevatedButton(
                                          onPressed: () {
                                            // Navigate to the view enquiries page
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewEnquiriesPage(
                                                  placeId: placeDetail['place'],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text('View Enquiries'),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPlaceStatus(int status) {
    switch (status) {
      case 0:
        return 'waiting';
      case 1:
        return 'accepted';
      case 2:
        return 'rejected';
      default:
        return 'Unknown';
    }
  }
}
