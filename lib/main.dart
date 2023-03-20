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
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);

  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    var flutterLocalNotificationsPlugin;
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

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
            // debugShowCheckedModeBanner: false,
            title: 'In Reservation',
            theme: ThemeData(
              textTheme: GoogleFonts.nunitoTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            // You can use the library anywhere in the app even in theme
            // theme: _iconBool ? ThemeData.dark() : ThemeData.light(),
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
