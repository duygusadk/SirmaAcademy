public class FragileItem extends  InventoryItem{

    private double weight;
    public FragileItem(String name, String category, double price, int quantity, boolean perishable, boolean breakable, String itemID,double weight) {
        super(name, category, price, quantity, perishable, breakable, itemID);
        this.weight=weight;
    }

    @Override
    public double calculateValue() {
        return getPrice()*getQuantity();
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }
}
