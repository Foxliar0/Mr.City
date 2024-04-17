import 'package:flutter/material.dart';
import 'package:mr_city/addplace.dart';
import 'package:mr_city/request.dart';
import 'package:mr_city/topbar.dart';

class Myplace extends StatefulWidget {
  const Myplace({super.key});

  @override
  State<Myplace> createState() => _MyplaceState();
}

class _MyplaceState extends State<Myplace> {
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
                fit: BoxFit.fill)),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Addplace(),
                              ));
                        },
                        child: Text('Add Place')))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Request(),
                              ));
                        },
                        child: Text('Request')))
              ],
            )
          ],
        ),
      ),
    );
  }
}
