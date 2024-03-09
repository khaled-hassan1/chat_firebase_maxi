import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quran_lastly/screens/auth_screen.dart';

import '../screens/chat_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final firebaseMessaging = FirebaseMessaging.instance;

  await firebaseMessaging.requestPermission();
  final fCMToken = await firebaseMessaging.getToken();
  debugPrint('....................Token.................: $fCMToken');
// final q=FirebaseMessaging.onMessage.listen((event) {
//   print(event.notification);
// });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
            displaySmall: TextStyle(color: Colors.white, fontSize: 20)),
        appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ChatScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
