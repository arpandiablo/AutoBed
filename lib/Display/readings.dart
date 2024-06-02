import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(const ReadingsScreen());
}

class ReadingsScreen extends StatefulWidget {
  const ReadingsScreen({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ReadingsScreen> {
  Timer? _timer;
  bool isLoading = true;
  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    readData();
    // Start a timer to refresh data every 60 seconds (you can adjust as needed)
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      readData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
  }

  Future<void> readData() async {
    var url =
        "https://smartcradle-61792-default-rtdb.asia-southeast1.firebasedatabase.app/message.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      // Convert the extractedData to a List of Map entries
      List<MapEntry<String, dynamic>> dataList = extractedData.entries.toList();

      // Sort the dataList by timestamp or unique key, depending on your data structure
      dataList.sort((a, b) {
        // Assuming you have a timestamp field in your data structure
        // Replace 'timestamp' with the actual timestamp field name
        // Also, ensure your timestamp field is in milliseconds
        var timestampA = a.value["Timestamp"];
        var timestampB = b.value["Timestamp"];
        return timestampB.compareTo(timestampA); // Sort in descending order
      });

      // Limit the dataList to the latest 10 entries
      dataList = dataList.take(10).toList();

      // Clear the existing dataList before adding the latest 10 entries
      this.dataList.clear();

      // Add the latest 10 entries to the dataList
      dataList.forEach((entry) {
        this.dataList.add({
          "Humidity": entry.value["Humidity"],
          "Temperature": entry.value["Temperature"],
          "SoundValue": entry.value["SoundValue"],
        });
      });

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Automatic Baby Cradle',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Automatic Baby Cradle"),
        ),
        body: isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: dataList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: Center(
                child: Text(
                  "Humidity: ${dataList[index]["Humidity"]}, Temperature: ${dataList[index]["Temperature"]}",
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
