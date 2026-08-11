import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:roomnest/providers/user_provider.dart';
// import 'package:roomnest/screens/owner/edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),

          const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white, size: 55),
          ),

          const SizedBox(height: 20),

          Text(
            user?.name ?? "",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),

          Text(
            user?.role ?? "",
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),

          const SizedBox(height: 30),

          Card(
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Full Name"),
              subtitle: Text(user?.name ?? ""),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: Text(user?.email ?? ""),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Phone"),
              subtitle: Text(user?.phone ?? ""),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.badge),
              title: const Text("Role"),
              subtitle: Text(user?.role ?? ""),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
              onPressed: () async {
                // await Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => const EditProfilePage()),
                // );

                if (!context.mounted) return;

                context.read<UserProvider>().getCurrentUser();
              },
            ),
          ),
        ],
      ),
    );
  }
}
