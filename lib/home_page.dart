import 'package:flutter/material.dart';
import 'package:myapp3/chat_page.dart';
import 'package:myapp3/components/drawer.dart';
import 'package:myapp3/components/user_tile.dart';
import 'package:myapp3/services/auth/auth_service.dart';
import 'package:myapp3/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(context), // Pass context to the function
    );
  }

  // Build a list of users except for the current logged-in user
  Widget _buildUserList(BuildContext context) {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        // Error handling
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading users'));
        }

        // Loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Ensure snapshot data is not null
        // if (!snapshot.hasData || snapshot.data == null) {
        //   return const Center(child: Text('No users found'));
        // }

        // Get users from the snapshot data and map to UserTile widgets
        return ListView(
          children: snapshot.data!.map<Widget>((userData) {
            return _buildUserListItem(userData, context);
          }).toList(),
        );
      },
    );
  }

  // build individual list tile for user
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    // Ensure that the 'name' field is non-null and has a fallback value if it's null
    String userName = userData['name'] ?? 'Unknown User';  // Default to 'Unknown User' if null

    // Ensure that the 'email' field is non-null and has a fallback value if it's null
    String userEmail = userData['email'] ?? 'No Email Provided';  // Default to 'No Email Provided' if null

    // Display all users except the current logged-in user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          // Tapped on a user -> go to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
