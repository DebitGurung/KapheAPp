class TPriceCalculator {
  static double calculateTotalPrice(double subTotal, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = subTotal * taxRate;

    double deliveryCost = getDeliveryCost(location);

    double totalPrice = subTotal + taxAmount + deliveryCost;
    return totalPrice;
  }

  static String calculateDeliveryCost(double beveragePrice, String location) {
    double deliveryCost = getDeliveryCost(location);
    return deliveryCost.toStringAsFixed(2);
  }

  static String calculateTaxAmount(double beveragePrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = beveragePrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    //check tax rate for the given location from a tax rate database or APi
    //return the appropriate tax rate
    return 0.10;
  }

  static double getDeliveryCost(String location) {
    //calculate the delivery cst for the given location using a delivery rate API
    //calculate the shipping cost based on factors
    return 5.00;
  }
}
