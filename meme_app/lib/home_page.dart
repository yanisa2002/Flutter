import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meme_app/auth_page.dart';

class HomePage extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Home",
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: (){
                auth.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=> AuthPage()));
              }, 
              child: Text(
                "Sign Out",
                style: TextStyle(fontSize: 20),
              ))
          ],
        ),
      ),
    );
  }
}