public class Payment {
    private double amount;

    public Payment(double amount) {
        this.amount = amount;
    }

    public void payment(double total) {
        if (amount > total) {
            System.out.println("Payment successful.");
        } else {
            System.out.println("Payment failed.");
        }
    }
}
