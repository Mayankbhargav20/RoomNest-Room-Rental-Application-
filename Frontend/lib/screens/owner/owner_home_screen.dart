import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:roomnest/providers/auth_provider.dart';
import 'package:roomnest/providers/user_provider.dart';
import 'package:roomnest/screens/auth/login_screen.dart';
import 'package:roomnest/screens/owner/add_room_page.dart';
import 'package:roomnest/screens/owner/my_room_page.dart';
import 'package:roomnest/screens/owner/owner_dashboard_page.dart';
import 'package:roomnest/screens/owner/profile_page.dart';
import 'package:roomnest/services/storage_service.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    OwnerDashboardPage(),
    AddRoomPage(),
    MyRoomsPage(),
    ProfilePage(),
  ];

  Future<void> _logout() async {
    await StorageService().deleteToken();

    if (!mounted) return;

    context.read<AuthProvider>().logout();
    context.read<UserProvider>().clearUser();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void _onItemTapped(int index) {
    if (index == 4) {
      _logout();
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: AppBar(title: const Text("Owner Dashboard"), centerTitle: true),

      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user?.name ?? ""),
              accountEmail: Text(user?.email ?? ""),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: _logout,
            ),
          ],
        ),
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_home),
            label: "Add Room",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work),
            label: "My Rooms",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
        ],
      ),
    );
  }
}
