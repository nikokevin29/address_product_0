part of 'services.dart';

class FirebaseFunction {
  searchProduct(String searchField) {
    return FirebaseFirestore.instance
        .collection('product')
        .where('name', isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }

  static Future<void> updateProduct({var id, var name, var stock}) async {
    return FirebaseFirestore.instance
        .collection('product')
        .doc(id)
        .update({'name': name, 'stock': stock})
        .then((value) => print('Product Updated'))
        .catchError((error) => print('Failed to Update Product'));
  }

  static Future<void> deleteProduct({var id}) async {
    return FirebaseFirestore.instance
        .collection('product')
        .doc(id)
        .delete()
        .then((value) => print('Product Deleted'))
        .catchError((error) => print('Failed to Delete Product'));
  }
}
