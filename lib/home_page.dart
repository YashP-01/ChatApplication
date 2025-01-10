import 'package:flutter/material.dart';
import 'package:myapp3/chat_page.dart';
import 'package:myapp3/components/drawer.dart';
import 'package:myapp3/components/user_tile.dart';
import 'package:myapp3/services/auth/auth_service.dart';
import 'package:myapp3/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(context),
    );
  }

  Widget _buildUserList(BuildContext context) {
    return StreamBuilder(
      stream: _chatService.getUserStream(), // Ensure this returns only current users
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading users'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No users found'));
        }

        final users = snapshot.data as List<Map<String, dynamic>>;

        final currentUser = _authService.getCurrentUser();
        if (currentUser == null) {
          return const Center(child: Text('No logged-in user found'));
        }

        // Filter to show only active users (exclude current user)
        final activeUsers = users.where((user) {
          final userEmail = user["email"] as String?;
          final userActive = user["isActive"] as bool? ?? false; // Adjust based on your schema
          return userEmail != null &&
              userActive &&
              userEmail != currentUser.email;
        }).toList();

        if (activeUsers.isEmpty) {
          return const Center(child: Text('No active users found'));
        }

        return ListView(
          children: activeUsers.map((user) => _buildUserListItem(user, context)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      text: userData["email"] ?? 'Unknown User',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData["email"] ?? '',
              receiverID: userData["uid"] ?? '',
            ),
          ),
        );
      },
    );
  }
}