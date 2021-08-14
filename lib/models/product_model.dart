part of 'models.dart';

class ProductModel {
  final String name;
  final int stock;
  final Timestamp createAt;

  ProductModel(
      {required this.name, required this.stock, required this.createAt});

  ProductModel.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        stock = int.parse(snapshot['stock'].toString()),
        createAt = snapshot['created_at'];
}
