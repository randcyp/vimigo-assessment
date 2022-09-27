import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/screens/add_entry.dart';
import 'package:intl/intl.dart';
import 'package:untitled2/screens/view_entry.dart';
import 'package:untitled2/models/check_in_record.dart';

// Shared preferences key values
const useRelativeTime = "use_relative_time";

class Home extends StatelessWidget {
  const Home({super.key, required this.name, required this.phone});

  final String name, phone;

  @override
  Widget build(BuildContext context) {
    debugPrint('newEntryName: $name');
    debugPrint('newEntryPhone: $phone');

    return MaterialApp(
      title: 'Attendance Record App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Attendance Record App',
        name: name,
        phone: phone,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.name,
    required this.phone
  });

  final String title, name, phone;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _useRelativeTime = false;
  String _filterString = "";
  bool _newEntryAdded = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load our preferences and update the UI
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _useRelativeTime = prefs.getBool(useRelativeTime) ?? false;
    });
  }

  // Save our preferences
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(useRelativeTime, _useRelativeTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Row(
              children: [
                Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _filterString = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Search for records by name or phone"
                      ),
                    )
                ),
              ],
            ),

            Row(
              children: [
                const Text("Display exact time"),
                Switch(
                  value: !_useRelativeTime,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      _useRelativeTime = !_useRelativeTime;
                      _savePreferences();
                    });
                  },
                ),
              ],
            ),

            // List of check-ins
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 350, maxHeight: 400),
              child: CheckInList(
                useRelativeTime: _useRelativeTime,
                filterString: _filterString.toLowerCase(),
                newEntryName: widget.name,
                newEntryPhone: widget.phone,
              ),

            ),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddEntry()
                    ),
                  );
                },
                child: const Text("Add an entry")
            )
          ],
        ),
      ),
    );
  }
}


class CheckInList extends StatelessWidget {
  CheckInList({super.key, required this.useRelativeTime,
  required this.filterString,
  required this.newEntryName,
  required this.newEntryPhone});

  final bool useRelativeTime;
  final String filterString, newEntryName, newEntryPhone;

  final List<CheckInRecord> entries =
      [
        CheckInRecord(
            "Chan Saw Lin",
            "0152131113",
            DateTime.parse("2020-06-30 16:10:05"),
        ),
        CheckInRecord(
            "Lee Saw Loy",
            "0161231346",
            DateTime.parse("2020-07-11 15:39:59"),
        ),
        CheckInRecord(
            "Khaw Tong Lin",
            "0158398109",
            DateTime.parse("2020-08-19 11:10:18"),
        ),
        CheckInRecord(
            "Lim Kok Lin",
            "0168279101",
            DateTime.parse("2020-08-19 11:11:35"),
        ),
        CheckInRecord(
            "Low Jun Wei",
            "0112731912",
            DateTime.parse("2020-08-15 13:00:05"),
        ),
        CheckInRecord(
            "Yong Weng Kai",
            "0172332743",
            DateTime.parse("2020-07-31 18:10:11"),
        ),
        CheckInRecord(
            "Jayden Lee",
            "0191236439",
            DateTime.parse("2020-08-22 08:10:38"),
        ),
        CheckInRecord(
            "Kong Kah Yan",
            "0111931233",
            DateTime.parse("2020-07-11 12:00:00"),
        ),
        CheckInRecord(
            "Jasmine Lau",
            "0162879190",
            DateTime.parse("2020-08-01 12:10:05"),
        ),
        CheckInRecord(
            "Chan Saw Lin",
            "016783239",
            DateTime.parse("2020-08-23 11:59:05"),
        ),
        CheckInRecord(
            "-1",
            "016783239",
            DateTime.fromMillisecondsSinceEpoch(0),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    if (newEntryName.isNotEmpty) {
      entries.add(CheckInRecord(newEntryName, newEntryPhone, DateTime.now()));
    }

    entries.sort((a, b) {
      return -a.checkInTime.difference(b.checkInTime).inHours;
    });

    var displayedEntries = entries.whereType();
    displayedEntries = entries.where((element) =>
        element.phone.toString().toLowerCase().contains(filterString) ||
        element.user.toString().toLowerCase().contains(filterString));

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
        itemCount: displayedEntries.length,
        itemBuilder: (BuildContext context, int i) {
          return CheckInItem(index: i, record: displayedEntries.elementAt(i),
              useRelativeTime: useRelativeTime);
        },
    );
  }


}

class CheckInItem extends StatelessWidget {

  CheckInItem({super.key, required this.index, required this.record,
    required this.useRelativeTime});

  final List<int> colorCodes = <int>[200, 50];
  final int index;
  final CheckInRecord record;
  final bool useRelativeTime;

  @override
  Widget build(BuildContext context) {
    String timeDisplay = DateFormat("dd MMM yyyy, h:mm a")
        .format(record.checkInTime)
        .toString();

    if (useRelativeTime) {
      int differenceInHours = DateTime.now()
          .difference(record.checkInTime)
          .inHours;
      timeDisplay = "$differenceInHours hours ago";
    }

    if (record.user != "-1") {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewEntry(entry: record)
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Ink(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name: ${record.user}",
                ),
                Text(
                    "Contact Info: ${record.phone}"
                ),
                Text(
                    "Checked in at: $timeDisplay"
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "You have reached the end of the list.",
            )
          ],
        ),
      );
    }
  }
}