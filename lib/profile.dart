import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade500,
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Icon
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 60, color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),

            // Username Display
            const Text(
              'Username',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const Text(
              'LitWorm_User', // This will be dynamic once you add Firebase
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            // Reset Password Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                // Show a confirmation dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Reset Password'),
                    content: const Text('Would you like to receive a password reset link via email?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Show a "Success" snackbar at the bottom
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Reset link sent to your email!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        child: const Text('Send Link'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.lock_reset),
              label: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}