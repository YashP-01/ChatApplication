import 'package:flutter/material.dart';
import 'package:myapp3/responsive/mobile_body.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MobileBody(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
