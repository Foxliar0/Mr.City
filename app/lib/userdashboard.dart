import 'package:flutter/material.dart';
import 'package:mr_city/login.dart';
import 'package:mr_city/topbar.dart';

// ignore: camel_case_types
class userdashboard extends StatelessWidget {
  const userdashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/download.jpg'),fit: BoxFit.cover)
          ),
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          child: const Padding(padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Topbar(
              ),
            SizedBox(height: 20),
            ],
          ),),
        ),
      ),
    );
  }
}