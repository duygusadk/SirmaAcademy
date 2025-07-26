import model.Room;
import model.User;
import service.BookingService;
import service.RoomService;
import service.UserService;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Path;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws IOException {

        String filePath="./src/1.csv";

        List<Room> rooms = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(String.valueOf(filePath)))) {
            String line= br.readLine();
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");
                rooms.add(new Room(
                        Integer.parseInt(data[0]),
                        data[1],
                        Double.parseDouble(data[2]),
                        Double.parseDouble(data[3]),
                        data[4]
                ));
            }
        }

        BookingService bookingService = new BookingService();
        RoomService roomService = new RoomService(rooms);
        UserService userService = new UserService();

        Scanner sc = new Scanner(System.in);

        System.out.println("1. View Rooms\n" + "2. Book a Room\n" + "3. Cancel Booking");

        int number = Integer.parseInt(sc.nextLine());
        LocalDate checkIn;
        LocalDate checkOut;
        switch (number) {
            case 1:
                System.out.println("Enter room type:");
                String roomType = sc.nextLine();
                System.out.print("Enter check-in date (YYYY-MM-DD): ");
                checkIn = LocalDate.parse(sc.nextLine());
                System.out.print("Enter check-out date (YYYY-MM-DD): ");
                checkOut = LocalDate.parse(sc.nextLine());
                List<Room> availableRooms = roomService.checkAvailableRooms(roomType, checkIn, checkOut);

                for (var i : availableRooms) {
                    System.out.println(i.getRoomNumber() + " " + i.getType() + " " + i.getPricePerNight() + " " + i.getCancellationFee());
                }
                break;
            case 2:
                if (login()) {
                    System.out.println("\nEnter room number to book: ");
                    int roomNumber = Integer.parseInt(sc.nextLine());
                    System.out.println("Enter check-in date (YYYY-MM-DD): ");
                    checkIn = LocalDate.parse(sc.nextLine());
                    System.out.print("Enter check-out date (YYYY-MM-DD): ");
                    checkOut = LocalDate.parse(sc.nextLine());

                    System.out.print("Enter your username: ");
                    String username = sc.nextLine();
                    User user = userService.getUserByName(username);
                    Room room = roomService.getRoomByRoomNumber(roomNumber);
                    if (room == null || !room.getStatus().equalsIgnoreCase("available")) {
                        System.out.println("Room not available for booking.");
                        return;
                    }
                    bookingService.bookRoom(room, user, checkIn, checkOut);
                    System.out.println("Room booked successfully! Total cost: $" +
                            bookingService.calculatePrice(room, checkIn, checkOut));
                }
                break;
            case 3:
                if (login()) {
                    System.out.print("\nEnter reservation ID to cancel: ");
                    String reservationId = sc.nextLine();
                    double cancellationFee = bookingService.cancelBooking(reservationId);
                    System.out.println("Booking canceled successfully. Cancellation fee: $" + cancellationFee);
                    break;
                }

        }
    }

    public static boolean login() {
        UserService userService = new UserService();

        Scanner sc = new Scanner(System.in);
        System.out.println("1.Login \n2.Register");
        int num = Integer.parseInt(sc.nextLine());
        //check invalid or not

        System.out.print("Enter username: ");
        String username = sc.nextLine();
        System.out.print("Enter password: ");
        String password = sc.nextLine();
        if (num == 1) {
            if (userService.registerUser(username, password)) {
                System.out.println("Registration successful!");
                return true;
            } else {
                System.out.println("Username already exists.");
            }
        } else {
            if (userService.logUser(username, password)) {
                System.out.println("Log in successful!");
                return true;
            } else {
                System.out.println("Invalid username or password");

            }
        }
        return false;

    }


}