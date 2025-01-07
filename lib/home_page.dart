import 'package:flutter/material.dart';
import 'package:myapp3/components/drawer.dart';
import 'package:myapp3/services/auth/auth_service.dart';
import 'package:myapp3/components/test.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,

      ),
      drawer: MyDrawer(),
      body: RecentChats(),
    );
  }
}

class RecentChats extends StatelessWidget {
  final List<Map<String, String>> chatData = [
    {
      'name': 'John Doe',
      'message': 'Hey, how are you?',
      'time': '10:30 AM',
      'image': 'https://via.placeholder.com/150 * 200'
    },
    {
      'name': 'Alice Smith',
      'message': 'Let'"'"'s meet tomorrow!',
    'time': '09:15 AM',
      'image': 'https://via.placeholder.com/150 * 200'
    },
    {
      'name': 'Bob Johnson',
      'message': 'See you later!',
      'time': 'Yesterday',
      'image': 'https://via.placeholder.com/150 * 150'
    },
    {
      'name': 'Charlie Brown',
      'message': 'Good morning!',
      'time': '2 days ago',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Diana White',
      'message': 'Happy Birthday!',
      'time': '5 days ago',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'John Doe',
      'message': 'Hey, how are you?',
      'time': '10:30 AM',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Alice Smith',
      'message': 'Let'"'"'s meet tomorrow!',
      'time': '09:15 AM',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Bob Johnson',
      'message': 'See you later!',
      'time': 'Yesterday',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Charlie Brown',
      'message': 'Good morning!',
      'time': '2 days ago',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Diana White',
      'message': 'Happy Birthday!',
      'time': '5 days ago',
      'image': 'https://via.placeholder.com/150'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: chatData.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(chatData[index]['image']!),
              ),
              title: Text(
                chatData[index]['name']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                chatData[index]['message']!,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis, // To handle overflow of long messages
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    chatData[index]['time']!,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          );
        },
      ),
    );
  }
}
