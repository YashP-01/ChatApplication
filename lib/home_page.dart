import 'package:flutter/material.dart';
import 'package:myapp3/chat_page.dart';
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
      'image': 'https://cdn-icons-png.flaticon.com/128/2922/2922506.png'
    },
    {
      'name': 'Alice Smith',
      'message': 'Let'"'"'s meet tomorrow!',
      'time': '09:15 AM',
      'image': 'https://cdn-icons-png.flaticon.com/128/4202/4202831.png'
    },
    {
      'name': 'Bob Johnson',
      'message': 'See you later!',
      'time': 'Yesterday',
      'image': 'https://cdn-icons-png.flaticon.com/128/18479/18479697.png'
    },
    {
      'name': 'Charlie Brown',
      'message': 'Good morning!',
      'time': '2 days ago',
      'image': 'https://cdn-icons-png.flaticon.com/128/3001/3001764.png'
    },
    {
      'name': 'Diana White',
      'message': 'Happy Birthday!',
      'time': '5 days ago',
      'image': 'https://cdn-icons-png.flaticon.com/128/2922/2922561.png'
    },
    {
      'name': 'John Doe',
      'message': 'Hey, how are you?',
      'time': '10:30 AM',
      'image': 'https://cdn-icons-png.flaticon.com/128/2922/2922506.png'
    },
    {
      'name': 'Alice Smith',
      'message': 'Let'"'"'s meet tomorrow!',
      'time': '09:15 AM',
      'image': 'https://cdn-icons-png.flaticon.com/128/4202/4202831.png'
    },
    {
      'name': 'Bob Johnson',
      'message': 'See you later!',
      'time': 'Yesterday',
      'image': 'https://cdn-icons-png.flaticon.com/128/18479/18479697.png'
    },
    {
      'name': 'Charlie Brown',
      'message': 'Good morning!',
      'time': '2 days ago',
      'image': 'https://cdn-icons-png.flaticon.com/128/3001/3001764.png'
    },
    {
      'name': 'Diana White',
      'message': 'Happy Birthday!',
      'time': '5 days ago',
      'image': 'https://cdn-icons-png.flaticon.com/128/2922/2922561.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: ListView.builder(
        itemCount: chatData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              // handle the tap event for card
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
                  receiverName: chatData[index]['name']!,
                  receiverImage: chatData[index]['image']!,
              ),
              ),
              );
            },
            child: Card(
              elevation: 1,
              // margin: EdgeInsets.symmetric(vertical: 7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),

              // list of widgets for all card
              child: ListTile(

                // image icon for all cards
                leading: CircleAvatar(
                  radius: 30,
                  foregroundImage: NetworkImage(chatData[index]['image']!),
                // fit: BoxFit.cover
                ),

                // text widget to show name of all the users
                title: Text(
                  chatData[index]['name']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                // text widget to showcase last message
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
              )
            ),
          );
        },
      ),
    );
  }
}
