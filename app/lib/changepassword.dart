import 'package:flutter/material.dart';

class chaangepass extends StatelessWidget {
  const chaangepass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('pch.jpg'),fit: BoxFit.fill),
          ),
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(20),
          child: Padding(padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255,139,1181,203),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color.fromARGB(248, 0, 0, 24)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  )
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: (){

                  }, child: Padding(padding: EdgeInsets.all(10),
                  child: Text('Submit',style: TextStyle(color: Color.fromARGB(255, 0, 0, 24)),),
                  )))
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