import 'package:roomnest/models/room.dart';
import 'package:roomnest/models/room_request.dart';
import 'package:roomnest/services/room_service.dart';

class RoomRepository {
  final RoomService _roomService = RoomService();

  // ================= GET ALL ROOMS =================

  Future<List<Room>> getAllRooms() async {
    return await _roomService.getAllRooms();
  }

  // ================= GET ROOM BY ID =================

  Future<Room> getRoomById(int id) async {
    return await _roomService.getRoomById(id);
  }

  // ================= ADD ROOM =================

  Future<Room> addRoom(RoomRequest request) async {
    return await _roomService.addRoom(request);
  }

  // ================= UPDATE ROOM =================

  Future<Room> updateRoom(int id, RoomRequest request) async {
    return await _roomService.updateRoom(id, request);
  }

  // ================= DELETE ROOM =================

  Future<String> deleteRoom(int id) async {
    return await _roomService.deleteRoom(id);
  }

  // ================= GET MY ROOMS =================

  Future<List<Room>> getMyRooms() async {
    return await _roomService.getMyRooms();
  }
}
