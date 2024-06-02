import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Automatic Baby Cradle'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'), // Background Image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut(); //Use this to Log Out user
            },
            child: const Text('Sign Out'),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Readings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            label: 'Video Feed',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/readings');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/videoFeed');
          }
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue,
        currentIndex: 0, // Set the initial index here
      ),
    );
  }
}