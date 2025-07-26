public abstract class AbstractItem implements  Item, Categorizable, Breakable, Perishable , Sellable{


    private String name;
    private String category;
    private double price;

    private boolean breakable;
    private boolean perishable;

    public AbstractItem(String name, String category, double price, boolean perishable,boolean breakable) {
        this.name = name;
        this.category = category;
        this.price = price;
        this.perishable=perishable;
        this.breakable=breakable;
    }

    @Override
    public boolean isBreakable() {
        return breakable;
    }

    @Override
    public void handleBreakage() {

    }

    @Override
    public void setCategory(String category) {
     this.category=category;
    }

    @Override
    public String getCategory() {
        return category;
    }


    public abstract double calculateValue();


    @Override
    public void displayItemDescription() {
        System.out.println(getItemDetails());
    }

    @Override
    public boolean isPerishable() {
        return perishable;
    }

    @Override
    public void handleExpiration() {

    }

    @Override
    public void setPrice(double price) {
    this.price=price;
    }

    @Override
    public double getPrice() {
        return price;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setBreakable(boolean breakable) {
        this.breakable = breakable;
    }

    public void setPerishable(boolean perishable) {
        this.perishable = perishable;
    }
}
