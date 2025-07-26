import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {
    private static final List<InventoryItem> inventory = FileIO.loadFile();

    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);
        boolean exit = false;

        while (!exit) {
            System.out.println("Inventory Management System");
            System.out.println("1. Add Item");
            System.out.println("2. Remove Item by ID");
            System.out.println("3. List Items");
            System.out.println("4. Order");
            System.out.println("5. Exit");
            System.out.print("Choose an option: ");
            int choice = Integer.parseInt(scanner.nextLine());

            switch (choice) {
                case 1:
                    addItem(scanner);
                    break;
                case 2:
                    //Adding new item in the inventory
                    System.out.println("Enter item id");
                    String id = scanner.nextLine();
                    deleteItemByItem(id);
                    System.out.println("Item is deleted");
                    break;
                case 3:
                    //List available items in the inventory
                    listItems();
                    break;
                case 4:
                    //Order
                    Order order = new Order();
                    String answer = "No";
                    //Adding items in the order while user leave the shopping cart
                    while (answer.equalsIgnoreCase("No")) {
                        System.out.println("Enter item name:");
                        String name = scanner.nextLine();
                        System.out.println("Enter quantity name:");
                        int quantity = Integer.parseInt(scanner.nextLine());

                        for (var item : inventory) {
                            if (item.getName().equalsIgnoreCase(name)) {
                                order.addItem(item, quantity);
                            } else {
                                System.out.println("No such item exists");
                            }
                        }
                        System.out.println("Leave cart(Yes,No):");
                        answer = scanner.nextLine();
                    }
                    System.out.println("Total: " + order.getTotal());
                    //Payment
                    System.out.println("1.Pay \n 2.Cancel");
                    int n = Integer.parseInt(scanner.nextLine());
                    System.out.println("Enter amount");
                    int amount = Integer.parseInt(scanner.nextLine());
                    switch (n) {
                        case 1:
                            Payment pay = new Payment(amount);
                            pay.payment(order.getTotal());
                            break;
                        case 2:
                            break;
                    }
                    break;
                case 5:
                    exit = true;
                    break;
                default:
                    System.out.println("Invalid option! Please try again.");

            }
        }
    }

    private static void listItems() {

        if (inventory.isEmpty()) {
            System.out.println("No items in inventory.");
        } else {
            for (InventoryItem item : inventory) {
                System.out.println(item.getItemDetails());
            }
        }
    }

    private static void deleteItemByItem(String itemId) {
        inventory.removeIf(item -> item.getItemID().equals(itemId));
    }

    private static void addItem(Scanner scanner) {
        System.out.print("Enter item name: ");
        String name = scanner.next();
        System.out.print("Enter category: ");
        String category = scanner.next();
        System.out.print("Enter price: ");
        double price = scanner.nextDouble();
        System.out.print("Enter quantity: ");
        int quantity = scanner.nextInt();
        System.out.print("Enter item type(fragile,grocery,electronic): ");
        String itemType = scanner.next();
        if (itemType.equalsIgnoreCase("fragile item")) {
            System.out.print("Enter weight: ");
            double weight = scanner.nextDouble();
            inventory.add(new FragileItem(name, category, price, quantity, false, true, "F00", weight));
        } else if (itemType.equalsIgnoreCase("electronic")) {
            inventory.add(new ElectronicsItem(name, category, price, quantity, false, true, "E00"));
        } else if (itemType.equalsIgnoreCase("grocery")) {
            System.out.print("Enter expiration date(yy-mm-dd): ");
            String date = scanner.next();
            inventory.add(new GroceryItem(name, category, price, quantity, true, false, "F00", date));
        }


        System.out.println("Item added successfully!");
    }
}