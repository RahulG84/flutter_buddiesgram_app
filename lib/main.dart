import 'package:flutter/material.dart';
import 'package:social_app_demo/pages/HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuddiesGram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        dialogBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        cardColor: Colors.white70,
        hintColor: Colors.black,
      ),
      home: const HomePage(),
    );
  }
}
