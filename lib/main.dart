import 'package:ababyc/Display/live_video.dart';
import 'package:ababyc/Display/readings.dart';
import 'package:ababyc/Pages/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Pages/home_screen.dart';
import 'Pages/login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Automatic Baby Cradle',
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return AuthScreen();
          }
        },
      ),
      routes: {
        "/regpage": (_) => RegScreen(),
        "/logpage": (_) => AuthScreen(),
        "/readings": (_) => const ReadingsScreen(),
        "/videoFeed": (_) => const VideoFeedScreen(),
      },
    );
  }
}