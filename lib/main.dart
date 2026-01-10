import 'package:flutter/material.dart';
import 'package:taskmanager_client/screens/MyHomePage.dart';

//we haven't used the testing and debugging for this application project
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Myhomepage(),
    );
  }
}
