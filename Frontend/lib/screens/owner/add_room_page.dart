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

  String? roomType;
  String? gender;

  bool get isEdit => widget.room != null;

  // These are only UI choices, not sent as default values.
  final List<String> roomTypes = ["Single", "Double", "1BHK"];

  final List<String> genders = ["MALE", "FEMALE", "ANY"];

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
              // Room Title
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Room Title",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter Room Title";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Rent
              TextFormField(
                controller: rentController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Monthly Rent",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.currency_rupee),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter Rent";
                  }

                  if (double.tryParse(value) == null) {
                    return "Enter valid rent";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Deposit
              TextFormField(
                controller: depositController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Security Deposit",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_balance_wallet),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter Deposit";
                  }

                  if (double.tryParse(value) == null) {
                    return "Enter valid deposit";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // City
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                ),
              ),

              const SizedBox(height: 15),

              // Area
              TextFormField(
                controller: areaController,
                decoration: const InputDecoration(
                  labelText: "Area",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.place),
                ),
              ),

              const SizedBox(height: 15),

              // Address
              TextFormField(
                controller: addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
              ),

              const SizedBox(height: 15),

              // Room Type
              DropdownButtonFormField<String>(
                value: roomType,
                decoration: const InputDecoration(
                  labelText: "Room Type",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.bed),
                ),
                hint: const Text("Select Room Type"),
                items: roomTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    roomType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Select room type";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Gender
              DropdownButtonFormField<String>(
                value: gender,
                decoration: const InputDecoration(
                  labelText: "Preferred Gender",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.people),
                ),
                hint: const Text("Select Preferred Gender"),
                items: genders.map((value) {
                  String displayValue;

                  switch (value) {
                    case "MALE":
                      displayValue = "Male";
                      break;
                    case "FEMALE":
                      displayValue = "Female";
                      break;
                    case "ANY":
                      displayValue = "Any";
                      break;
                    default:
                      displayValue = value;
                  }

                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(displayValue),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Select preferred gender";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Description
              TextFormField(
                controller: descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Room Description",
                  hintText: "Describe the room, facilities, nearby places etc.",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter room description";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              // Add / Update Button
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
                            rent: double.parse(rentController.text.trim()),
                            deposit: double.parse(
                              depositController.text.trim(),
                            ),
                            city: cityController.text.trim(),
                            area: areaController.text.trim(),
                            address: addressController.text.trim(),
                            roomType: roomType!,
                            gender: gender!,
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

                            _clearForm();
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

  void _clearForm() {
    _formKey.currentState?.reset();

    titleController.clear();
    rentController.clear();
    depositController.clear();
    cityController.clear();
    areaController.clear();
    addressController.clear();
    descriptionController.clear();

    setState(() {
      roomType = null;
      gender = null;
    });
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
