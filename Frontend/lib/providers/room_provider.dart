import 'package:flutter/material.dart';
import 'package:roomnest/models/room.dart';
import 'package:roomnest/models/room_request.dart';
import 'package:roomnest/repository/room_repository.dart';

class RoomProvider extends ChangeNotifier {
  final RoomRepository _repository = RoomRepository();

  List<Room> _rooms = [];
  Room? _selectedRoom;

  bool _isLoading = false;
  String? _errorMessage;

  List<Room> get rooms => _rooms;
  Room? get selectedRoom => _selectedRoom;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ================= GET ALL ROOMS =================

  Future<void> getAllRooms() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _rooms = await _repository.getAllRooms();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // ================= GET ROOM BY ID =================

  Future<void> getRoomById(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _selectedRoom = await _repository.getRoomById(id);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // ================= ADD ROOM =================

  Future<bool> addRoom(RoomRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final room = await _repository.addRoom(request);

      _rooms.add(room);

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _errorMessage = e.toString();

      _isLoading = false;
      notifyListeners();

      return false;
    }
  }

  // ================= UPDATE ROOM =================

  Future<bool> updateRoom(int id, RoomRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedRoom = await _repository.updateRoom(id, request);

      final index = _rooms.indexWhere((room) => room.id == id);

      if (index != -1) {
        _rooms[index] = updatedRoom;
      }

      _selectedRoom = updatedRoom;

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _errorMessage = e.toString();

      _isLoading = false;
      notifyListeners();

      return false;
    }
  }

  // ================= DELETE ROOM =================

  Future<bool> deleteRoom(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.deleteRoom(id);

      _rooms.removeWhere((room) => room.id == id);

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _errorMessage = e.toString();

      _isLoading = false;
      notifyListeners();

      return false;
    }
  }

  void clearRooms() {
    _rooms.clear();
    _selectedRoom = null;
    notifyListeners();
  }

  // ================= GET MY ROOMS =================

  Future<void> getMyRooms() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _rooms = await _repository.getMyRooms();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
