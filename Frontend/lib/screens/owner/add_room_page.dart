import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:roomnest/models/room.dart';
import 'package:roomnest/models/room_request.dart';
import 'package:roomnest/providers/room_provider.dart';

class AddRoomPage extends StatefulWidget {
  final Room? room;

  const AddRoomPage({super.key, this.room});

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final rentController = TextEditingController();
  final depositController = TextEditingController();
  final cityController = TextEditingController();
  final areaController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

  String roomType = "Single";
  String gender = "MALE";

  bool get isEdit => widget.room != null;

  @override
  void initState() {
    super.initState();

    if (isEdit) {
      final room = widget.room!;

      titleController.text = room.title;
      rentController.text = room.rent.toString();
      depositController.text = room.deposit.toString();
      cityController.text = room.city;
      areaController.text = room.area;
      addressController.text = room.address;
      descriptionController.text = room.description;

      roomType = room.roomType;
      gender = room.gender;
    }
  }

  @override
  Widget build(BuildContext context) {
    final roomProvider = context.watch<RoomProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEdit ? "Edit Room" : "Add Room"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Room Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Room Title";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: rentController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Monthly Rent",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Rent";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: depositController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Security Deposit",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Deposit";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: areaController,
                decoration: const InputDecoration(
                  labelText: "Area",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: roomProvider.isLoading
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          final request = RoomRequest(
                            title: titleController.text.trim(),
                            rent: double.parse(rentController.text),
                            deposit: double.parse(depositController.text),
                            city: cityController.text.trim(),
                            area: areaController.text.trim(),
                            address: addressController.text.trim(),
                            roomType: roomType,
                            gender: gender,
                            description: descriptionController.text.trim(),
                          );

                          bool success;

                          if (isEdit) {
                            success = await roomProvider.updateRoom(
                              widget.room!.id,
                              request,
                            );
                          } else {
                            success = await roomProvider.addRoom(request);
                          }

                          if (!mounted) return;

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isEdit
                                      ? "Room Updated Successfully"
                                      : "Room Added Successfully",
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );

                            if (isEdit) {
                              Navigator.pop(context, true);
                              return;
                            }

                            _formKey.currentState!.reset();

                            titleController.clear();
                            rentController.clear();
                            depositController.clear();
                            cityController.clear();
                            areaController.clear();
                            addressController.clear();
                            descriptionController.clear();

                            setState(() {
                              roomType = "Single";
                              gender = "MALE";
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  roomProvider.errorMessage ??
                                      "Operation Failed",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                  child: roomProvider.isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          isEdit ? "Update Room" : "Add Room",
                          style: const TextStyle(fontSize: 18),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    rentController.dispose();
    depositController.dispose();
    cityController.dispose();
    areaController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
