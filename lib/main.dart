import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:riseuptracker/database/MongoDatabase.dart';
import 'package:riseuptracker/screens/AdminLoginPage.dart';
import 'package:riseuptracker/screens/FeedbackForm.dart';
import 'package:riseuptracker/screens/MainDashboard.dart';
import 'package:riseuptracker/screens/MarkAttendance.dart';
import 'package:riseuptracker/screens/createNewSession/create_new_sessions.dart';
import 'package:riseuptracker/screens/attendeeDashboard.dart';
import 'package:riseuptracker/screens/createNewSession/ongoing_session_page.dart';
import 'package:riseuptracker/screens/medicalDetails.dart';
import 'package:riseuptracker/screens/personalDetails.dart';
import 'package:riseuptracker/screens/qrcode/GenerateQRcode.dart';
import 'package:riseuptracker/screens/signup_page.dart';
import 'package:riseuptracker/screens/splash.dart';
import 'package:riseuptracker/utils/routes.dart';
import 'firebase_options.dart';
import 'screens/qrcode/QRScanner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await MongoDatabase.connect() ;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riseup Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => AttendancePage(
              sessionTitle: 'Save Water',
            ),
        //"/": (context) => const splash(),
        MyRoutes.loginRoute: (context) => const AdminLoginPage(),
        MyRoutes.signupRoute: (context) => const RegistrationForm(),
      },
    );
  }
}
