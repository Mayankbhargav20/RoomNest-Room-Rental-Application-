package com.roomnest.service;

import com.roomnest.dto.RoomRequest;
import com.roomnest.dto.RoomResponse;
import com.roomnest.entity.Room;
import com.roomnest.repo.RoomRepo;
import com.roomnest.repo.UserRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import com.roomnest.entity.User;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RoomService {

    private final RoomRepo roomRepository;
    private final UserRepo userRepository;

    public RoomResponse addRoom(RoomRequest request) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        String email = authentication.getName();

        User owner = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Owner not found"));

        Room room = Room.builder()
                .title(request.getTitle())
                .rent(request.getRent())
                .deposit(request.getDeposit())
                .city(request.getCity())
                .area(request.getArea())
                .address(request.getAddress())
                .roomType(request.getRoomType())
                .gender(request.getGender())
                .description(request.getDescription())
                .available(true)
                .owner(owner)
                .build();

        Room savedRoom = roomRepository.save(room);

        return mapToResponse(savedRoom);
    }

    public RoomResponse updateRoom(Long id, RoomRequest request) {

        Room room = roomRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Room not found"));

        room.setTitle(request.getTitle());
        room.setRent(request.getRent());
        room.setDeposit(request.getDeposit());
        room.setCity(request.getCity());
        room.setArea(request.getArea());
        room.setAddress(request.getAddress());
        room.setRoomType(request.getRoomType());
        room.setGender(request.getGender());
        room.setDescription(request.getDescription());

        Room updatedRoom = roomRepository.save(room);

        return mapToResponse(updatedRoom);
    }

    public void deleteRoom(Long id) {

        Room room = roomRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Room not found"));

        roomRepository.delete(room);
    }

    public List<RoomResponse> getAllRooms() {

        return roomRepository.findAll()
                .stream()
                .map(this::mapToResponse)
                .toList();
    }

    public RoomResponse getRoomById(Long id) {

        Room room = roomRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Room not found"));

        return mapToResponse(room);
    }

    private RoomResponse mapToResponse(Room room) {

        return RoomResponse.builder()
                .id(room.getId())
                .title(room.getTitle())
                .rent(room.getRent())
                .deposit(room.getDeposit())
                .city(room.getCity())
                .area(room.getArea())
                .address(room.getAddress())
                .roomType(room.getRoomType())
                .gender(room.getGender())
                .description(room.getDescription())
                .available(room.isAvailable())
                .build();
    }

    public List<RoomResponse> getMyRooms() {

        Authentication authentication =
                SecurityContextHolder.getContext().getAuthentication();

        String email = authentication.getName();

        User owner = userRepository.findByEmail(email)
                .orElseThrow(() ->
                        new RuntimeException("Owner not found"));

        return roomRepository.findByOwner(owner)
                .stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }
}