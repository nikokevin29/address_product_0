part of 'services.dart';


class Boxes {
  static Box<ProductAddressModel> getProductAddress() => Hive.box<ProductAddressModel>('transaction');

}