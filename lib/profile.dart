import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart'; // Ensure this points to your file containing the Login/MyApp class

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Get the current user from Firebase
    final User? user = FirebaseAuth.instance.currentUser;

    // 2. Create a Username from the Email (e.g., "john@gmail.com" -> "john")
    // If user is null, it shows "Guest"
    String username = "Guest";
    if (user?.email != null) {
      username = user!.email!.split('@')[0];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Picture Placeholder
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurple.shade500,
              child: const Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Display Username
            const Text(
              "Username",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            Text(
              username,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            // Display Full Email below
            Text(
              user?.email ?? "",
              style: TextStyle(color: Colors.deepPurple.shade100, fontSize: 14),
            ),

            const SizedBox(height: 40),

            // FIXED: Logout button
            ElevatedButton.icon(
              onPressed: () async {
                // A. Sign out from Firebase
                await FirebaseAuth.instance.signOut();

                // B. Force navigation back to the Login Screen (MyApp)
                // and clear the entire navigation history
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                        (route) => false,
                  );
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}