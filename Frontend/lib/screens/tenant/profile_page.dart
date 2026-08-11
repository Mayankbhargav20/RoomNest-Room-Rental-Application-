import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomnest/providers/auth_provider.dart';
import 'package:roomnest/providers/user_provider.dart';
import 'package:roomnest/screens/auth/login_screen.dart';
import 'package:roomnest/services/storage_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    await StorageService().deleteToken();

    if (!context.mounted) return;

    context.read<AuthProvider>().logout();
    context.read<UserProvider>().clearUser();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

          const SizedBox(height: 20),

          Text(
            user?.name ?? "",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 30),

          Card(
            child: ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: Text(user?.email ?? ""),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Phone"),
              subtitle: Text(user?.phone ?? ""),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.badge),
              title: const Text("Role"),
              subtitle: Text(user?.role ?? ""),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
              onPressed: () {
                // Next module
              },
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              onPressed: () => _logout(context),
            ),
          ),
        ],
      ),
    );
  }
}
