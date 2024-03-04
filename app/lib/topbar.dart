import 'package:flutter/material.dart';
import 'package:mr_city/login.dart';
import 'package:mr_city/myprofile.dart';

class Topbar extends StatelessWidget {
  const Topbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back,color: Color.fromARGB(255, 5, 4, 4),)),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile(),));
          }, icon: Icon(Icons.person,color: Color.fromARGB(255, 5, 3, 3),))
        ],
      ),
    );
  }
}