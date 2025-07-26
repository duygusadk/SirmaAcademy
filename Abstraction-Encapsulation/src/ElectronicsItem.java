public class ElectronicsItem extends  InventoryItem{


    public ElectronicsItem(String name, String category, double price, int quantity, boolean perishable, boolean breakable, String itemID) {
        super(name, category, price, quantity, perishable, breakable, itemID);
    }

    @Override
    public double calculateValue() {
        return getPrice()*getQuantity();
    }
}
