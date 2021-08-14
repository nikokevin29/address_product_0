part of 'models.dart';

class ProductModel {
  final String name;
  final int stock;
  final DateTime createAt;

  ProductModel(
      {required this.name, required this.stock, required this.createAt});

  ProductModel.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        stock = snapshot['stock'],
        createAt = snapshot['created_at'];


  // List<ProductModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
  //   return querySnapshot.docs.map((snapshot) {
  //     final Map<String, dynamic> dataMap = this.fromMap(snapshot.data(),reference: snapshot.reference);

  //     return ProductModel(
  //       name: dataMap['name'],
  //       stock: dataMap['description'],
  //       createAt: dataMap['create_at'],
  //     );
  //   }).toList();
  // }
}
