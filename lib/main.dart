import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tedxvitb/screens/home_screen.dart';
import 'package:tedxvitb/screens/login_screen.dart';
import 'package:tedxvitb/utils/firebase_tools.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "homes" : (context) => const HomeScreen(),
        "logins" : (context) => const LoginScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'TedxVITB',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: auth.currentUser == null ? const LoginScreen() : const HomeScreen(),
    );
  }
}
