import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:riseuptracker/database/MongoDatabase.dart';
import 'package:riseuptracker/screens/AdminLoginPage.dart';
import 'package:riseuptracker/screens/qrcode/GenerateQRcode.dart';
import 'package:riseuptracker/screens/signup_page.dart';
import 'package:riseuptracker/screens/splash.dart';
import 'package:riseuptracker/utils/routes.dart';
import 'firebase_options.dart';

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
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        //"/": (context) => GeneratePage(),
         "/": (context) => const splash(),
        MyRoutes.loginRoute: (context) => const AdminLoginPage(),
        MyRoutes.signupRoute: (context) => const RegistrationForm(),
      },
    );
  }
}
