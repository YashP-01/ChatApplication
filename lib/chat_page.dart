import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp3/components/chat_bubble.dart';
import 'package:myapp3/home_page.dart';
import 'package:myapp3/services/auth/auth_service.dart';
import 'package:myapp3/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  // Text controller
  final TextEditingController _messageController = TextEditingController();

  // Chat & Auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // Send message
  void sendMessage() async {
    // If there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      // Send the message
      await _chatService.sendMessage(receiverID, _messageController.text);

      // Clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,  // works as arrow back icon
        title: Text(receiverEmail),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Display all messages
          Expanded(
            child: _buildMessageList(),
          ),
          // User input field
          _buildUserInput(),
        ],
      ),
    );
  }

  // Build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        // Errors
        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }

        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if data is present
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No messages"));
        }

        // Return list view with messages
        return ListView(
          reverse: true,
          children: snapshot.data!.docs.map((doc) {
            return _buildMessageItem(doc);
          }).toList(),
        );
      },
    );
  }

  // Build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // align message to the right if sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)
          ],
        )
    );
  }

  // Build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Type a message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // Send button
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle
            ),
            margin: const EdgeInsets.all(15),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward),
            ),
          ),
        ],
      ),
    );
  }
}
