import 'package:flutter/material.dart';
import 'package:untitled2/screens/home.dart';

class AddEntry extends StatelessWidget {
  AddEntry({super.key});

  String newEntryName = "";
  String newEntryPhone = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Check In Page"),
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              children: [const Text("Name: "), Expanded(child: TextField(
                onChanged: (value) {
                  newEntryName = value;
                },
              ))],
            ),
            Container(height: 16),
            Row(
              children: [const Text("Phone: "), Expanded(child: TextField(
                onChanged: (value) {
                  newEntryPhone = value;
                },
              ))],
            ),
            Container(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(
                          name: newEntryName,
                          phone: newEntryPhone)
                  ),
                );
              },
              child: const Text("Confirm"),
            ),
          ]),
        ));
  }
}
