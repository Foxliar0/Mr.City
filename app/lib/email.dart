import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController _emailController=TextEditingController();

  Future<void> resetPassword(BuildContext context) async {
    String email = _emailController.text;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password Reset Email Sent'),
            content: const Text(
              'An email with instructions to reset your password has been sent to your email address.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password Reset Failed'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            // image: DecorationImage(image: AssetImage('pch.jpg'),fit: BoxFit.fill),
          ),
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(20),
          child: Padding(padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
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
resetPassword(context);
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