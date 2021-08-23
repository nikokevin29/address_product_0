part of 'services.dart';

class HiveServices {
  static Future addTransaction(String productName, int qty) async {
    final transaction = ProductAddressModel()
      ..productName = productName
      ..qty = qty;

    final box = Boxes.getProductAddress();
    await box.add(transaction);
  }

  static editTransaction(
      ProductAddressModel transaction, String productName, int qty) {
    transaction.productName = productName;
    transaction.qty = qty;

    transaction.save();
  }

  static deleteTransaction(ProductAddressModel transaction) {
    transaction.delete();
  }
}
