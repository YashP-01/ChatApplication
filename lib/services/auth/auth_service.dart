import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instance of auth & Firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      // Sign user in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Mark user is active in Firestore
      if (userCredential.user != null) {
        bool myuser = true;
        await _firestore.collection('Users').doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
            'isActive': myuser, // Mark as active
          },
          SetOptions(merge: false), // Update existing fields without overwriting
        );
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailPassword(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }

    try {
      // Create user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user info in Firestore
      if (userCredential.user != null) {
        await _firestore.collection('Users').doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
            'isActive': true, // Mark as active upon sign-up
          },
        );
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      // Mark user as inactive before signing out
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('Users').doc(user.uid).update(
          {'isActive': false}, // Mark as inactive
        );
      }

      await _auth.signOut();
    } catch (e) {
      throw Exception('Error signing out: ${e.toString()}');
    }
  }

  // Update user status
  Future<void> updateUserStatus(String userId, bool isActive) async {
    try {
      await _firestore.collection('Users').doc(userId).update(
        {'isActive': isActive},
      );
    } catch (e) {
      throw Exception('Error updating user status: ${e.toString()}');
    }
  }
}
