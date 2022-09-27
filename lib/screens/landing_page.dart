import 'package:flutter/material.dart';
import 'package:untitled2/screens/home.dart';

// Shared preferences key values
const useRelativeTime = "use_relative_time";

void main() {
  runApp(const LandingPage());
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Record App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Introduction"),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Filter through records by typing in the search bar.\n"
                  "The \"Display exact time\" toggle let's you toggle between "
                  "relative time displays and absolute time displays.\n\n\n"
                  "Click on any of the list items to view a record in more "
                  "detail.\n"
                  "Upon clicking any of the list items, you will be brought "
                  "to the record viewer, where you can share the selected "
                  "record's details with other applications.\n\n\n"
                  "To check in, press the \"Add an entry\" button and "
                  "press \"Confirm\" when you are happy with the check"
                  " in details. Have fun!",
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Home(name: "", phone: "")
                        ),
                      );
                    },
                    child: const Text("Home Page")),
              ]),
        ));
  }
}
