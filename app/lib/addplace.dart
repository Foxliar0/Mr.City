import 'package:flutter/material.dart';
import 'package:mr_city/topbar.dart';

class Addplace extends StatefulWidget {
  const Addplace({super.key});

  @override
  State<Addplace> createState() => _AddplaceState();
}

class _AddplaceState extends State<Addplace> {
  List<Map<String, dynamic>> district = [
    {'id': 'thrissur', 'name': 'Thrissur'},
    {'id': 'ernakulam', 'name': 'Errnakulam'},
    {'id': 'kollam', 'name': 'Kollam'},
  ];

  String? selectdistrict;

  List<Map<String, dynamic>> place = [
    {'id': 'wadakkanchery', 'name': 'Wadakkanchery'},
    {'id': 'aluva', 'name': 'Aluva'},
    {'id': 'guruvayoor', 'name': 'Guruvayoor'},
  ];

  String? selectlocation;
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
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundColor: Color.fromARGB(255, 92, 92, 97),
                            child: Icon(
                              Icons.add,
                              size: 40,
                              color: Color.fromARGB(255, 0, 0, 0),
                              )
                          ),
                          Positioned(
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
                          ) 
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectdistrict,
                  decoration: InputDecoration(
                    label: const Text('District'),
                    hintText: 'Select District',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 3, 3, 3), // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectdistrict = newValue;
                    });
                  },
                  isExpanded: true,
                  items: district.map<DropdownMenuItem<String>>(
                    (Map<String, dynamic> dist) {
                      return DropdownMenuItem<String>(
                        value: dist['id'],
                        child: Text(dist['name']),
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                          value: selectlocation,
                          decoration: InputDecoration(
                            label: const Text('Location'),
                            hintText: 'Select Location',
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0), // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0), // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectlocation = newValue;
                            });
                          },
                          isExpanded: true,
                          items: place.map<DropdownMenuItem<String>>(
                            (Map<String, dynamic> place) {
                              return DropdownMenuItem<String>(
                                value: place['id'],
                                child: Text(place['name']),
                              );
                            },
                          ).toList(),
                        ),
                const SizedBox(height: 20),
                TextFormField(
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
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 139, 181, 203),
                    hintText: 'Details',
                    hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0))
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: ElevatedButton(onPressed: (){
                    }, child: const Text('Sumbit'),))
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