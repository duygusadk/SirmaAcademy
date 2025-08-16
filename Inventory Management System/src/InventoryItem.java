public class InventoryItem extends AbstractItem{

    private String itemID;
    private int quantity;

    public InventoryItem(String name, String category, double price, int quantity, boolean perishable, boolean breakable,String itemID) {
        super(name, category, price,  perishable, breakable);
        this.itemID = itemID;
        this.quantity = quantity;
    }

    @Override
    public String getItemDetails() {
        return String.format("Name: %s, Category: %s,  Price: %.2f,Quantity: %b",
                getName(), getCategory(), getPrice(),quantity);
    }

    @Override
    public double calculateValue() {
        return quantity*getPrice();
    }

    public String getItemID() {
        return itemID;
    }

    public void setItemID(String itemID) {
        this.itemID = itemID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
