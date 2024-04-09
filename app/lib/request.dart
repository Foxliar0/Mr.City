import 'package:flutter/material.dart';
import 'package:mr_city/topbar.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/qwert.jpg'), fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const Topbar(),
              SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 139, 181, 203),
                    hintText: 'Details',
                    hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
