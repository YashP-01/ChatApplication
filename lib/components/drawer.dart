import 'package:flutter/material.dart';
import 'package:myapp3/login_screen.dart';
import 'package:myapp3/settings_page.dart';
import 'package:myapp3/services/auth/auth_service.dart';
import 'package:myapp3/components/test.dart';
import 'package:myapp3/themes/light_mode.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void signOut(){
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // logo
                DrawerHeader(
                  child: Center(
                    child: Icon(Icons.account_circle,
                      color: Colors.grey.shade300,
                      size: 110,),
                  ),
                ),
                // home list title
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text('HOME'),
                    leading: Icon(Icons.home),
                    onTap: (){
                      // pop the drawer
                      Navigator.pop(context);
                    },
                  ),
                ),

                // settings list title
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text('SETTINGS'),
                    leading: Icon(Icons.settings),
                    onTap: (){
                      // navigate to the settings page
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),
                      ));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 100 * 4),

            // logout list title
            Padding(
              padding: const EdgeInsets.only(left: 100.0 * 0.3,),
              child: ListTile(
                title: Text('LOGOUT'),
                leading: Icon(Icons.logout),
                onTap: (){
                  signOut();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


// status bar title
// Padding(
//   padding: const EdgeInsets.only(left: 25.0),
//   child: ListTile(
//     title: Text('Test'),
//     leading: Icon(Icons.roundabout_left_sharp),
//     onTap: (){
//       // navigate to the settings page
//       Navigator.push(context, MaterialPageRoute(builder: (context) => MyTest(),
//       ));
//     },
//   ),
// ),

