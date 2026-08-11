import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:roomnest/providers/room_provider.dart';
import 'package:roomnest/screens/owner/add_room_page.dart';

class MyRoomsPage extends StatefulWidget {
  const MyRoomsPage({super.key});

  @override
  State<MyRoomsPage> createState() => _MyRoomsPageState();
}

class _MyRoomsPageState extends State<MyRoomsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RoomProvider>().getMyRooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    final roomProvider = context.watch<RoomProvider>();

    if (roomProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (roomProvider.errorMessage != null) {
      return Center(child: Text(roomProvider.errorMessage!));
    }

    if (roomProvider.rooms.isEmpty) {
      return const Center(
        child: Text(
          "No Rooms Added Yet",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => roomProvider.getMyRooms(),
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: roomProvider.rooms.length,
        itemBuilder: (context, index) {
          final room = roomProvider.rooms[index];

          return Card(
            elevation: 5,
            margin: const EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text("City : ${room.city}"),
                  Text("Area : ${room.area}"),

                  const SizedBox(height: 8),

                  Text(
                    "₹${room.rent}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddRoomPage(room: room),
                              ),
                            );

                            if (updated == true && mounted) {
                              context.read<RoomProvider>().getMyRooms();
                            }
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text("Edit"),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () async {
                            bool success = await roomProvider.deleteRoom(
                              room.id,
                            );

                            if (!mounted) return;

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Room Deleted Successfully"),
                                  backgroundColor: Colors.green,
                                ),
                              );

                              roomProvider.getMyRooms();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    roomProvider.errorMessage ??
                                        "Delete Failed",
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text("Delete"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
