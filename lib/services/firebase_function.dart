part of 'services.dart';

class FirebaseFunction {
  static Future<void> createProduct({var name, var stock}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFunction.createLog(user!.displayName! + ' menambahkan '+ name + ' dengan stok '+ stock);
    return FirebaseFirestore.instance
        .collection('product')
        .add({
          'name': name,
          'stock': int.tryParse(stock) ?? 0,
          'created_at': DateTime.now(),
        })
        .then((value) => print('Product Added'))
        .catchError((error) => print('Failed to Add Product'));
  }

  static Future<void> updateProduct({var id, var name, var stock}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFunction.createLog(user!.displayName! + ' mengubah stock '+ name + ' menjadi '+ stock);
    return FirebaseFirestore.instance
        .collection('product')
        .doc(id)
        .update({'name': name, 'stock': stock})
        .then((value) => print('Product Updated'))
        .catchError((error) => print('Failed to Update Product'));
  }

  static Future<void> deleteProduct({var id,var name}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    FirebaseFunction.createLog(user!.displayName! + ' menghapus produk '+ name);
    return FirebaseFirestore.instance
        .collection('product')
        .doc(id)
        .delete()
        .then((value) => print('Product Deleted'))
        .catchError((error) => print('Failed to Delete Product'));
  }
  static Future<void> createLog(var action) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    return FirebaseFirestore.instance.collection('logs').add({
      'created_at': DateTime.now(),
      'user': user!.displayName,
      'action': action,
    }).then((value) => print('Log Created'))
        .catchError((error) => print('Failed to Report Log'));
  }
}
