import 'package:hive/hive.dart';

part 'product_address_model.g.dart';

@HiveType(typeId: 0)
class ProductAddressModel extends HiveObject {
  @HiveField(0)
  late String productName;

  @HiveField(1)
  late int qty;
}