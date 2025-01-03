import 'package:flutter/material.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size information
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Padding for the screen, adjusts based on screen size
    EdgeInsetsGeometry padding = screenWidth > 600
        ? EdgeInsets.symmetric(horizontal: 100)  // For larger screens like tablets
        : EdgeInsets.symmetric(horizontal: 20);  // For smaller screens like phones

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: padding,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Responsive logo or header, adjusted based on screen width
                Icon(
                  Icons.account_circle,
                  size: screenWidth * 0.3,  // Size will adjust based on screen width
                  color: Colors.blue,
                ),
                SizedBox(height: 20),

                // Sign-Up Form
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Region',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                TextField(
                  //obscureText: _obsecureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    //obscureText: true,
                  ),
                ),
                SizedBox(height: 30),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    // Handle Sign-Up action
                  },
                  child: Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth * 0.8, 50), // Button width is 80% of screen width
                  ),
                ),

                SizedBox(height: 20),

                // Footer Text for login redirection
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        // Navigate to login page
                      },
                      child: Text('Log In'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// return Scaffold(
//   // backgroundColor: Colors.purple[200],
//   appBar: AppBar(
//     backgroundColor: Colors.orangeAccent,
//     title: Text('Sign Up'),
//     centerTitle: true,
//   ),
//     );
//   }