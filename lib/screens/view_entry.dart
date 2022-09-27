import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:untitled2/models/check_in_record.dart';

class ViewEntry extends StatelessWidget {
  const ViewEntry({super.key, required this.entry});

  final CheckInRecord entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Entry Viewer"),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text(
              entry.toString(),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: () {
                  Share.share(entry.toString());
                  },
                child: const Text("Share Contact Info")),
          ]),
        ));
  }
}
