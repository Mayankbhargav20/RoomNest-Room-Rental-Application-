import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomnest/providers/room_provider.dart';

import 'providers/auth_provider.dart';
import 'screens/splash/splash_screen.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(const RoomNestApp());
}

class RoomNestApp extends StatelessWidget {
  const RoomNestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RoomProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "RoomNest",
        home: const SplashScreen(),
      ),
    );
  }
}
