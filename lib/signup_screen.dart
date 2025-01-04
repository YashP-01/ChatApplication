import 'package:flutter/material.dart';
import 'package:myapp3/login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // TextEditingController for each TextFormField
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Gender selection state
  String? _selectedGender;

  // Password validation function
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

  // Handle gender change
  void _handleGenderChange(String? value) {
    setState(() {
      _selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    EdgeInsetsGeometry padding = screenWidth > 600
        ? EdgeInsets.symmetric(horizontal: 100)
        : EdgeInsets.symmetric(horizontal: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    //   floatingActionButton: FloatingActionButton(
    //       onPressed: (){},
    //       child: Icon(Icons.add),
    //   backgroundColor: Colors.black26,
    //   foregroundColor: Colors.white,
    //
    // ),
      body: Padding(
        padding: padding,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.account_circle,
                  size: screenWidth * 0.3,
                  color: Colors.lightBlue,
                ),
                SizedBox(height: 25),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!RegExp(r"^[a-zA-Z0-9@.]+$").hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // Gender Selection (Radio Buttons)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Gender',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 10, // Horizontal space between radio buttons
                        runSpacing: 10, // Vertical space between radio buttons
                        children: [
                          // Male Radio Button
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Male',
                                groupValue: _selectedGender,
                                onChanged: _handleGenderChange,
                              ),
                              Text("Male"),
                            ],
                          ),
                          // Female Radio Button
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Female',
                                groupValue: _selectedGender,
                                onChanged: _handleGenderChange,
                              ),
                              Text("Female"),
                            ],
                          ),
                          // Other Radio Button
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Other',
                                groupValue: _selectedGender,
                                onChanged: _handleGenderChange,
                              ),
                              Text("Other"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // TextField(
                      //   decoration: InputDecoration(
                      //     labelText: 'Country',
                      //     border: OutlineInputBorder(),
                      //   ),
                      // ),
                      // SizedBox(height: 20),
                      //
                      // TextField(
                      //   decoration: InputDecoration(
                      //     labelText: 'Region',
                      //     border: OutlineInputBorder(),
                      //   ),
                      // ),
                      // SizedBox(height: 20),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: _validatePassword,
                      ),
                      SizedBox(height: 20),

                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 35),

                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Signing up...')));

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Please fill all the fields correctly.')));
                          }
                        },
                        child: Text('Sign Up'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(screenWidth * 0.8, 50),
                        ),
                      ),
                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?'),
                          TextButton(
                            onPressed: () {
                              // Navigate to login page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text('Log In'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
