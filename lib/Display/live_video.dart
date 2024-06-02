import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoFeedScreen extends StatefulWidget {
  const VideoFeedScreen({Key? key}) : super(key: key);

  @override
  VideoFeedScreenState createState() => VideoFeedScreenState();
}

class VideoFeedScreenState extends State<VideoFeedScreen> {
  @override
  void initState() {
    super.initState();
    _launchURL();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _launchURL,
            child: const Text('Live Video Feed'),
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    final Uri url = Uri.parse('http://192.168.171.134/mjpeg/1');
    if (!await launch(url.toString())) {
      throw 'Could not launch $url';
    }
  }
}

void main() {
  runApp(const VideoFeedScreen());
}
