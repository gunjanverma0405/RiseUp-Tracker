import 'package:flutter/material.dart';

import 'AdminLoginPage.dart';
import 'attendeeLoginPage.dart';

class UserTypePage extends StatefulWidget {
  @override
  _UserTypePageState createState() => _UserTypePageState();
}

class _UserTypePageState extends State<UserTypePage> {
  String userType = "";
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse('FFF6DC31', radix: 16)),

      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Select User Type:',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                setState(() {
                  userType = 'Admin';
                  selectedIndex = 0;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedIndex == 0 ? Colors.lightBlue : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/admin.png',
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(width: 80),
                      Text(
                        'Admin',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                setState(() {
                  userType = 'Attendee';
                  selectedIndex = 1;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedIndex == 1 ? Colors.lightBlue : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/attendees.png',
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(width: 70),
                      Text(
                        'Attendee',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            if (userType != null)
              Text(
                'Selected User Type: $userType',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            if (userType == 'Admin') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminLoginPage()),
              );
            } else if (userType == 'Attendee') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AttendeeLoginPage()),
              );
            }
          },
          child: Icon(Icons.arrow_forward),
          backgroundColor: Colors.blue,
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
