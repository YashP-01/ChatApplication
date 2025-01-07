import 'package:flutter/material.dart';

class MyTest extends StatelessWidget {
  const MyTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Status Bar'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StatusBar(),
        ),
      ),
    );
  }
}

class StatusBar extends StatelessWidget {
  final List<Map<String, String>> statusData = [
    {'name': 'My Status', 'image': 'https://via.placeholder.com/150'},
    {'name': 'John', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Alice', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Bob', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Charlie', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Diana', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Eve', 'image': 'https://via.placeholder.com/150'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: statusData.length,
      itemBuilder: (context, index) {
        // First item is for "My Status" (user's own profile)
        bool isMyStatus = index == 0;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,  // To show overflow icons (like the "+" icon)
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(statusData[index]['image']!),
                    backgroundColor: Colors.grey[300],
                  ),
                  if (isMyStatus)
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.add,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                statusData[index]['name']!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isMyStatus ? FontWeight.bold : FontWeight.normal,
                  color: isMyStatus ? Colors.green : Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
