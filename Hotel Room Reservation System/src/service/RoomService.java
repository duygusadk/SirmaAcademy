package service;

import model.Room;
import model.RoomType;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class RoomService {

    private final List<Room> rooms;
    public RoomService(List<Room> rooms) {
        this.rooms = rooms;
    }


    public List<Room> checkAvailableRooms(String roomType, LocalDate checkIn, LocalDate checkOut) {

        List<Room> availableRooms = new ArrayList<>();

        for (var i : rooms) {
            if (i.getType().equalsIgnoreCase(roomType) && i.getStatus().equalsIgnoreCase("available")) {
                availableRooms.add(i);
            }
        }

        return availableRooms;
    }

    public Room getRoomByRoomNumber(int roomNumber) {
        for (var room : rooms) {
            if (room.getRoomNumber() == roomNumber) {
                return room;
            }
        }
        return null;
    }


}
