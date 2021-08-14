part of 'pages.dart';

class AddCigarettes extends StatefulWidget {
  const AddCigarettes({Key? key}) : super(key: key);

  @override
  _AddCigarettesState createState() => _AddCigarettesState();
}

class _AddCigarettesState extends State<AddCigarettes> {
  TextEditingController productName = TextEditingController();
  TextEditingController productStock = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference product = firestore.collection('product');
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Rokok Baru'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
          child: Column(
            children: [
              SizedBox(height: 15),
              TextField(
                controller: productName,
                decoration: InputDecoration(labelText: "Nama Produk"),
                autocorrect: false,
              ),
              TextField(
                controller: productStock,
                decoration: InputDecoration(labelText: "Stok Produk"),
                autocorrect: false,
                keyboardType: TextInputType.number,
              ),
              Divider(height: 25),
              SizedBox(
                height: 50,
                width: 100,
                child: TextButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (productName.text.trim() == '' &&
                        productStock.text.trim() == '') {
                      Get.snackbar(
                          'Warning!!', 'Nama dan Stok tidak boleh kosong');
                    } else {
                      product.add({
                        'name': productName.text,
                        'stock': int.tryParse(productStock.text) ?? 0,
                        'created_at': DateTime.now(),
                      });
                      productStock.text = '';
                      productName.text = '';
                      Get.back();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
