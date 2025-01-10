import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp3/models/message.dart';

class ChatService {

  // get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return FirebaseFirestore.instance
        .collection('Users')
        .where('isActive', isEqualTo: true) // Fetch only active users
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }


  // send message
  Future<void> sendMessage(String receiverId, String message) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderID: currentUserID, // Fix: Use currentUserID as senderID
      senderEmail: currentUserEmail, // Fix: Use currentUserEmail as senderEmail
      receiverID: receiverId,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverId];
    ids.sort();
    String chatRoomID = ids.join('_');

    // add new message to the database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages") // Fix: Ensure this matches the `getMessages` collection name
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {

    // construct the chat room id for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages") // Fix: Consistent naming with `sendMessage`
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
}