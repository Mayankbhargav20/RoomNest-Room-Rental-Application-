import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:roomnest/providers/room_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RoomProvider>().getAllRooms();
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
        child: Text("No Rooms Available", style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: roomProvider.rooms.length,
      itemBuilder: (context, index) {
        final room = roomProvider.rooms[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 15),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),
                    const SizedBox(width: 5),
                    Expanded(child: Text("${room.area}, ${room.city}")),
                  ],
                ),

                const SizedBox(height: 8),

                Text(room.address, style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Chip(label: Text(room.roomType)),

                    const SizedBox(width: 10),

                    Chip(label: Text(room.gender)),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  "Rent : ₹${room.rent}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Deposit : ₹${room.deposit}",
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(room.description),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: room.available ? () {} : null,
                    child: Text(
                      room.available ? "View Details" : "Not Available",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
