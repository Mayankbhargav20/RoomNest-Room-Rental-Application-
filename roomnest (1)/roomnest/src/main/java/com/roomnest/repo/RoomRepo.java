package com.roomnest.repo;

import com.roomnest.entity.Room;
import com.roomnest.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RoomRepo extends JpaRepository<Room, Long> {



        List<Room> findByOwner(User owner);

    List<Room> findByCityIgnoreCaseAndAreaIgnoreCaseAndRentBetweenAndRoomTypeIgnoreCaseAndAvailableTrue(
            String city,
            String area,
            Double minRent,
            Double maxRent,
            String roomType
    );
}