import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp3/login_screen.dart';
import 'package:myapp3/signup_screen.dart';

import '../../home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            // user is loged in
            if(snapshot.hasData){
              return HomePage();
            }
            // user not logged in
            else {
              return SignupScreen();
            }
          }
      ),
    );
  }
}
