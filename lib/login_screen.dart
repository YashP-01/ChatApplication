import 'package:flutter/material.dart';
import 'package:myapp3/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    EdgeInsetsGeometry padding = screenWidth > 600
        ? EdgeInsets.symmetric(horizontal: 100)
        : EdgeInsets.symmetric(horizontal: 20);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Sign in', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              // Navigate back to SignupScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupScreen()),
              );
            },
        ),
      ),
    );
  }
}
