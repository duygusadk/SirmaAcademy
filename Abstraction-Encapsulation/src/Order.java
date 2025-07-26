import java.util.ArrayList;
import java.util.List;

public class Order {
    public List<InventoryItem> items = new ArrayList<>();
    public double total;

    public void addItem(InventoryItem item, int quantity) {
        if (item.getQuantity() >= quantity) {
            items.add(item);
            total += item.getPrice() * quantity;
            item.setQuantity(item.getQuantity() - quantity);
        } else {
            System.out.println("Not enough stock");
        }
    }

    public double getTotal() {
        return total;
    }


}
