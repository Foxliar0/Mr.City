import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mr_city/topbar.dart';

class BusRoute extends StatefulWidget {
  const BusRoute({super.key});

  @override
  State<BusRoute> createState() => _BusRouteState();
}

class _BusRouteState extends State<BusRoute> {
  List<Map<String, dynamic>> data = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> placeSnapshot =
          await db.collection('routes').get();
      List<Map<String, dynamic>> routesList = [];
      for (var doc in placeSnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        data['routes_id'] = doc.id;
        data['fromLocationid'] = doc["fromLocation"];
        data['toLocationid'] = doc["toLocation"];
        data['kilometer'] = double.parse(doc["kilometer"]);
        data['route_name'] = doc["name"];
        String fromlocationName = await getLocationName(doc["fromLocation"]);
        String tolocationName = await getLocationName(doc["toLocation"]);
        data['fromLocation'] = fromlocationName;
        data['toLocation'] = tolocationName;
        List<Map<String, dynamic>> scheduleData =
            await getScheduleByRouteId(doc.id);
        for (var item in scheduleData) {
          data['schedule_name'] = item['name'];
          data['schedule_time'] = item['time'];
        }
        routesList.add(data);
      }
      setState(() {
        data = routesList;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<String> getLocationName(String locationId) async {
    try {
      final locationSnapshot = await FirebaseFirestore.instance
          .collection('Location')
          .doc(locationId)
          .get();

      if (locationSnapshot.exists) {
        final locationData = locationSnapshot.data();
        if (locationData != null) {
          return locationData['location'] ?? '';
        }
      }
    } catch (e) {
      print('Error getting location name: $e');
    }
    return '';
  }

  Future<List<Map<String, dynamic>>> getScheduleByRouteId(String routeId) async {
    try {
      final scheduleSnapshot = await FirebaseFirestore.instance
          .collection('schedule')
          .where('routes', isEqualTo: routeId)
          .get();

      if (scheduleSnapshot.docs.isNotEmpty) {
        return scheduleSnapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'name': data['name'],
            'time': data['time'],
          };
        }).toList();
      }
    } catch (e) {
      print('Error getting schedule by route ID: $e');
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/download.jpg'), fit: BoxFit.cover)),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Topbar(),
            Expanded(
              child: FutureBuilder(
                future: Future.value(data.isNotEmpty ? data : null),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (snapshot.data == null) {
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final route = snapshot.data![index];
                      return Card(
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
                                route['route_name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.location_on),
                                  const SizedBox(width: 8),
                                  Text(route['fromLocation']),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward),
                                  const SizedBox(width: 8),
                                  Text(route['toLocation']),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${route['kilometer']} km',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Bus Name: ${route['schedule_name']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Time: ${route['schedule_time']}',
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}