import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vsing/pages/HomePage.dart';
import 'package:vsing/pages/detail_table.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'vsing rsv',
      home: HomePage(),
    );
  }
}

// class lewat extends StatelessWidget {
//   const lewat({super.key});

//   @override
//   Widget build(BuildContext context) => ChangeNotifierProvider(
//         create: (context) => GoogleSignInProvider(),
//         child: cek(),
//       );
// }
