import 'package:flutter/material.dart';
import 'package:myapp3/auth/auth_service.dart';
import 'package:myapp3/home_page.dart';
import 'package:myapp3/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
  }
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // bool isValidUsername(String username) {
  //   final usernameRegex = RegExp(r'^[a-zA-Z._]+$');
  //   return usernameRegex.hasMatch(username);
  // }

  bool isValidEmail(String email) {
    // Regular expression for validating email
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(email);
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    EdgeInsetsGeometry padding = screenWidth > 600
        ? EdgeInsets.symmetric(horizontal: 100)
        : EdgeInsets.symmetric(horizontal: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
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
      body: Padding(
          padding: padding,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: screenWidth * 0.25,
                    color: Colors.lightBlue,
                  ),
                  SizedBox(height: 25),

                  Form(
                    key: _formKey,
                      child: Column(
                        children: [
                          // TextFormField(
                          //   controller: _usernameController,
                          //   decoration: InputDecoration(
                          //       labelText: 'Username',
                          //       border: OutlineInputBorder()
                          //   ),
                          //   validator: (value){
                          //     if(value == null || value.isEmpty){
                          //       return 'Please enter username';
                          //     } else if(!isValidUsername(value)){
                          //       return 'Username cannot contain numbers or special characters.';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // SizedBox(height: 20),

                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder()
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address';
                              } else if (!isValidEmail(value)) {
                                return 'Invalid email address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'password',
                              border: OutlineInputBorder()
                            ),
                            validator: _validatePassword,
                          ),
                          SizedBox(height: 35),

                          ElevatedButton(
                            onPressed: () async {
                              // auth service
                              final authService = AuthService();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()),
                              );
                              // try login
                              try {
                                await authService.signInWithEmailPassword(_emailController.text, _passwordController.text);
                              }

                              // catch any errors
                              catch (e) {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(e.toString()),
                                    ),
                                );
                              }
                            },
                            child: Text('Log in'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(screenWidth * 0.8, 50),
                            ),
                          ),
                      SizedBox(height: 20),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text('dont have an account?'),
                              TextButton(
                                  onPressed: (){
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignupScreen()),
                                    );
                              }, child: Text('register now'))
                            ],
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}
