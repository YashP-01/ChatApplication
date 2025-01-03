import 'package:flutter/material.dart';
import 'package:myapp3/responsive/desktop_body.dart';
import 'package:myapp3/responsive/mobile_body.dart';
import 'package:myapp3/responsive/responsive_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: ResponsiveLayout(
      //     mobileBody: MobileBody(),
      //     desktopBody: DesktopBody()),
    );
  }
}




    // final currentWidth = MediaQuery.of(context).size.width;
    // final currentHeight = MediaQuery.of(context).size.height;
    //
    // return Scaffold(
    //   backgroundColor:
    //   currentWidth < 600 ? Colors.deepPurpleAccent : Colors.blueAccent,
    //   body: Center(
    //     child: Text(currentWidth.toString()),

