package service;

import model.Booking;
import model.Room;
import model.User;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

public class BookingService {

    private List<Room> rooms;
    private List<User> users;
    private List<Booking> bookings;

    public void bookRoom(Room room, User userName, LocalDate checkIn, LocalDate checkOut) {

        double total = calculatePrice(room, checkIn, checkOut);
        Booking booking = new Booking(UUID.randomUUID(), room, userName, checkIn, checkOut, total);
        bookings.add(booking);
        room.setStatus("booked");
    }

    public double cancelBooking(String reservationId) {
        double cancellationFee = 0;
        for (var i : bookings) {
            if (Objects.equals(i.getReservationId(), reservationId)) {
                i.getRoom().setStatus("available");
                cancellationFee = i.getRoom().getCancellationFee();
                bookings.remove(i);
            }
        }
        return cancellationFee;
    }

    public double calculatePrice(Room room, LocalDate checkIn, LocalDate checkOut) {
        long days = checkOut.toEpochDay() - checkIn.toEpochDay();

        return days * room.getPricePerNight();
    }
}
