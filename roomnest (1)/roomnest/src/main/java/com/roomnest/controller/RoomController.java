package com.roomnest.controller;

import com.roomnest.dto.RoomRequest;
import com.roomnest.dto.RoomResponse;
import com.roomnest.service.RoomService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/rooms")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class RoomController {

    private final RoomService roomService;

    @PostMapping
    public ResponseEntity<RoomResponse> addRoom(
            @RequestBody RoomRequest request) {

        RoomResponse response = roomService.addRoom(request);

        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<RoomResponse>> getAllRooms() {

        return ResponseEntity.ok(roomService.getAllRooms());
    }

    @GetMapping("/{id}")
    public ResponseEntity<RoomResponse> getRoomById(
            @PathVariable Long id) {

        return ResponseEntity.ok(roomService.getRoomById(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<RoomResponse> updateRoom(
            @PathVariable Long id,
            @RequestBody RoomRequest request) {

        return ResponseEntity.ok(roomService.updateRoom(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteRoom(
            @PathVariable Long id) {

        roomService.deleteRoom(id);

        return ResponseEntity.ok("Room Deleted Successfully");
    }

    @GetMapping("/my")
    public ResponseEntity<List<RoomResponse>> getMyRooms() {

        return ResponseEntity.ok(roomService.getMyRooms());
    }
}