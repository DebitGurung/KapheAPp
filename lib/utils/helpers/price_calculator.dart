class TPriceCalculator {
  static double calculateTotalPrice(double beveragePrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = beveragePrice * taxRate;

    double deliveryCost = getDeliveryCost(location);

    double totalPrice = beveragePrice + taxAmount + deliveryCost;
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
    return 0.10;
  }

  static double getDeliveryCost(String location) {
    return 5.00;
  }
}
