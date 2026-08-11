import 'package:dio/dio.dart';
import 'package:roomnest/models/room.dart';
import 'package:roomnest/models/room_request.dart';
import 'package:roomnest/services/dio_client.dart';

class RoomService {
  final Dio _dio = DioClient().dio;

  // ================= GET ALL ROOMS =================

  Future<List<Room>> getAllRooms() async {
    try {
      final response = await _dio.get("/rooms");

      List data = response.data;

      return data.map((json) => Room.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to fetch rooms");
    }
  }

  // ================= GET ROOM BY ID =================

  Future<Room> getRoomById(int id) async {
    try {
      final response = await _dio.get("/rooms/$id");

      return Room.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to fetch room");
    }
  }

  // ================= DELETE ROOM =================

  Future<String> deleteRoom(int id) async {
    try {
      final response = await _dio.delete("/rooms/$id");

      return response.data.toString();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to delete room");
    }
  }

  // ================= ADD ROOM =================

  Future<Room> addRoom(RoomRequest request) async {
    try {
      final response = await _dio.post("/rooms", data: request.toJson());

      return Room.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to add room");
    }
  }

  // ================= UPDATE ROOM =================

  Future<Room> updateRoom(int id, RoomRequest request) async {
    try {
      final response = await _dio.put("/rooms/$id", data: request.toJson());

      return Room.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to update room");
    }
  }

  // ================= GET MY ROOMS =================

  Future<List<Room>> getMyRooms() async {
    try {
      final response = await _dio.get("/rooms/my");

      List data = response.data;

      return data.map((json) => Room.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to fetch your rooms",
      );
    }
  }
}
