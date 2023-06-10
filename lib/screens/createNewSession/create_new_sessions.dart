import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'package:riseuptracker/database/db_connects.dart';

import '../qrcode/GenerateQRcode.dart';

class CreateNewSessionPage extends StatefulWidget {
  final String tileName; // Pass the tile name as a parameter

  const CreateNewSessionPage({Key? key, required this.tileName}) : super(key: key);

  @override
  _CreateNewSessionPageState createState() => _CreateNewSessionPageState();
}

class _CreateNewSessionPageState extends State<CreateNewSessionPage> {
  String? sessionTitle;
  DateTime? sessionDate;
  String? sessionLocation;
  late String sessionTag;

  @override
  void initState() {
    super.initState();
    // Assign the tileName directly to the sessionTag
    sessionTag = widget.tileName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Create New Session'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Session Title'),
              onChanged: (value) {
                setState(() {
                  sessionTitle = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                // Open date picker and set the selected date to sessionDate
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2024),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    setState(() {
                      sessionDate = selectedDate;
                    });
                  }
                });
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Session Date',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(sessionDate != null
                        ? sessionDate!.toString().substring(0, 10)
                        : 'Select a date'),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Session Location'),
              onChanged: (value) {
                setState(() {
                  sessionLocation = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            Text(
              'Session Tag: $sessionTag',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),

            const SizedBox(height: 40.0),
            Container(
              width: 200.0, // Adjust the width as per your requirements
              child: ElevatedButton(
                onPressed: () async {
                  if (sessionTitle != null &&
                      sessionDate != null &&
                      sessionLocation != null) {
                    final db = await mongo_dart.Db.create(dbURl);
                    await db.open();
                    // Insert the data into the collection
                    await db.collection("Sessions").insert({
                      'Title': sessionTitle,
                      'Date' : sessionDate,
                      'Location': sessionLocation,
                      'Tag' : sessionTag
                    });
                    final snackBar = SnackBar(
                      content: const Text('Session Added!!'),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        textColor: const Color.fromARGB(255, 35, 19, 19),
                        label: 'Dismiss',
                        onPressed: () {},
                      ),
                      backgroundColor: Colors.blue,
                    );
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackBar);

                    //final insertedId = result['_id'].toHexString();
                    final objectID = mongo_dart.ObjectId();
                    final id = objectID.toHexString();
                    await db.close();
                    /*Navigator.push(
                     context,
                      MaterialPageRoute(
                        builder: (context) => GenerateQRcode(sessionID: id),
                      ),
                    );*/
                    // Implement the logic to save the session details
                    // You can use the sessionTitle, sessionDate, sessionLocation, and sessionTag variables
                  }else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Incomplete Session Details'),
                          content: const Text('Please fill in all session details.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 20.0),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 18.0),
                  primary: Colors.blueAccent, // Set the desired color here
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

