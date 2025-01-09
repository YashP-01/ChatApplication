import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;  // Text field is properly initialized
  final void Function()? onTap;  // Fixed 'onTap' declaration

  const UserTile({
    super.key,
    required this.text,  // Proper initialization of 'text'
    required this.onTap,  // Proper initialization of 'onTap'
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,  // onTap callback used here
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(20),  // Added const here for consistency
        child: Row(
          children: [
            const Icon(Icons.person),  // User icon

            const SizedBox(width: 20),

            Text(text),  // Display the passed text
          ],
        ),
      ),
    );
  }
}
