public class GroceryItem extends  InventoryItem{
    private String expirationDate;
    public GroceryItem(String name, String category, double price, int quantity, boolean perishable, boolean breakable,String itemId, String expirationDate) {
        super(name, category, price, quantity, perishable, breakable,itemId);
        this.expirationDate=expirationDate;
    }

    @Override
    public double calculateValue() {
        return getPrice()*getQuantity();
    }

    public String getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(String expirationDate) {
        this.expirationDate = expirationDate;
    }
}
