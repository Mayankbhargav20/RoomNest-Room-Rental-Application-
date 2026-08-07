package com.roomnest.repo;

import com.roomnest.entity.Room;
import com.roomnest.entity.RoomImage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RoomImageRepo extends JpaRepository<RoomImage, Long> {

    List<RoomImage> findByRoom(Room room);

}
