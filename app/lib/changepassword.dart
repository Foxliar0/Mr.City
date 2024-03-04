import 'package:flutter/material.dart';

class chaangepass extends StatelessWidget {
  const chaangepass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/register.jpg'),fit: BoxFit.cover)
          ),
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(20),
          child: Padding(padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255,139,181,203),
                  labelText: 'Old password',
                  labelStyle: TextStyle(color: Color.fromARGB(251, 1, 1, 8)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide.none,
                  )
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255,139,181,203),
                  labelText: 'New password',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 1, 1, 4)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  )
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255,139,181,203),
                  labelText: 'Retype password',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 24)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  )
                ),
              ),SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: (){
          
                  }, child: Padding(padding: EdgeInsets.all(10),
                  child: Text('Change Password',style: TextStyle(color: Color.fromARGB(255, 0, 0, 24)),),
                  ))
                  )
                ],
              )
            ],
          ),
          ),
        ),
      )
    );
  }
}