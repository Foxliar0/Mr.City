import 'package:flutter/material.dart';
import 'package:mr_city/topbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mr_city/userrequest.dart';

// ignore: camel_case_types
class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  List<Map<String, dynamic>> placedata = [];
  String selectdistrict = '';
  String selectlocation = '';
  String selecttype = '';

  List<Map<String, dynamic>> district = [];
  List<Map<String, dynamic>> location = [];
  List<Map<String, dynamic>> type = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

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

  Future<void> _fetchPlaceData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;

      QuerySnapshot<Map<String, dynamic>> placeSnapshot = await db
          .collection('place')
          .where('user id', isNotEqualTo: userId)
          .where('location', isEqualTo: selectlocation)
          .where('type', isEqualTo: selecttype)
          .where('status', isEqualTo: 1)
          .get();

      List<Map<String, dynamic>> placedetails = [];
      for (var doc in placeSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        data['place'] = doc["place"];
        data['details'] = doc["details"];
        placedetails.add(data);
      }
      setState(() {
        placedata = placedetails;
        print(placedata);
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDistrict();
    fetchType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/download.jpg'), fit: BoxFit.cover)),
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Topbar(),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value:
                            selectdistrict.isNotEmpty ? selectdistrict : null,
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
                        value:
                            selectlocation.isNotEmpty ? selectlocation : null,
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
                      ElevatedButton(
                        onPressed: () {
                          _fetchPlaceData();
                        },
                        child: const Text('Sumbit'),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SendRequest(id: placeDetail['id']),));
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
