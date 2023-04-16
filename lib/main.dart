import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vsing/auth/loginpage.dart';
import 'package:vsing/pages/HomePage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(540, 960),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'In Reservation',
            theme: ThemeData(
              textTheme: GoogleFonts.nunitoTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            home: auth());
      },
    );
  }
}

class auth extends StatelessWidget {
  const auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return call_home();
          } else {
            return call_login();
          }
        },
      ),
    );
  }
}

class call_home extends StatefulWidget {
  const call_home({super.key});

  @override
  State<call_home> createState() => _call_homeState();
}

class _call_homeState extends State<call_home> {
  bool load = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        load = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (load == false)
        ? HomePage()
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 56, 43, 83),
              ),
            ),
          );
  }
}

class call_login extends StatefulWidget {
  const call_login({super.key});

  @override
  State<call_login> createState() => _call_loginState();
}

class _call_loginState extends State<call_login> {
  bool load = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        load = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (load == false)
        ? LoginPage()
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 56, 43, 83),
              ),
            ),
          );
  }
}
