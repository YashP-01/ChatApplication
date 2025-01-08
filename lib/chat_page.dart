import 'package:flutter/material.dart';
import 'package:myapp3/home_page.dart';

class ChatPage extends StatelessWidget {
  final String receiverName;
  final String receiverImage;

  const ChatPage({super.key, required this.receiverName, required this.receiverImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Text(receiverName),
        ),
          // centerTitle: true,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){
                    // Navigate back to HomeScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: CircleAvatar(
                  maxRadius: 21,
                  foregroundImage: NetworkImage(receiverImage),),
              )
            ],
          ),
      ),
    );
  }
}
