package com.roomnest.service;

import com.roomnest.dto.RoomResponse;
import com.roomnest.entity.Room;
import com.roomnest.repo.RoomRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SearchService {

    private final RoomRepo roomRepository;

    public List<RoomResponse> searchRooms(
            String city,
            String area,
            Double minRent,
            Double maxRent,
            String roomType) {

        List<Room> rooms = roomRepository.findByCityIgnoreCaseAndAreaIgnoreCaseAndRentBetweenAndRoomTypeIgnoreCaseAndAvailableTrue(
                        city,
                        area,
                        minRent,
                        maxRent,
                        roomType
                );


        return rooms.stream()
                .map(this::mapToResponse)
                .toList();
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
                .available(room.isAvailable()) // or getAvailable() depending on your entity
                .build();
    }
}