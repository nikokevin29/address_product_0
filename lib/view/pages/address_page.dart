part of 'pages.dart';

class AddressPage extends StatefulWidget {
  final TabController controller;
  AddressPage({required this.controller});

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController nameController = TextEditingController();
  @override
  // void dispose() {
  //   Hive.box('transaction').close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alamat Minyak Gula Terigu'),
        actions: [
          GestureDetector(
            onTap: () {
              //Get.to(page);//Tambah Alamat
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          child: Column(
            children: [
              SizedBox(
                height: 9,
              ),
              Text('Nama Pembeli',
                  style: blackTextFont.copyWith(
                    fontSize: 18,
                  )),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
                enableSuggestions: false,
                autocorrect: false,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: nameController.clear,
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      final box = Boxes.getProductAddress();
                      if (box.isNotEmpty) {
                        box.clear();
                      } else {
                        Get.snackbar('Daftar Sudah Kosong',
                            'Tidak ada produk di daftar barang',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white,
                            icon: Icon(
                              Icons.warning,
                              color: Colors.red,
                            ));
                      }
                      setState(() {});
                    },
                    child: Text('Kosongkan'),
                  ),
                  TextButton(
                    child: Text('Print'),
                    onPressed: () {
                      //TODO: HERE
                      //print Logic
                      PrinterServices.printAddress('Nama Pelanggan','ACI GA 2'); //For testing purpose

                      Boxes.getProductAddress().clear(); // clear Hive List
                      nameController.text = ''; //clear name
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Get.to(() => SearchMinyak());
                    },
                    child: Text('Cari Barang'),
                  ),
                ],
              ),
              ValueListenableBuilder<Box<ProductAddressModel>>(
                  valueListenable: Boxes.getProductAddress().listenable(),
                  builder: (context, box, _) {
                    final transactions =
                        box.values.toList().cast<ProductAddressModel>();

                    return buildContent(transactions);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildContent(List<ProductAddressModel> transactions) {
  if (transactions.isEmpty) {
    return Center(
      child: Text(
        'Produk Kosong',
        style: TextStyle(fontSize: 24),
      ),
    );
  } else {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (BuildContext context, int index) {
            final transaction = transactions[index];

            return buildTransaction(context, transaction);
          },
        ),
      ],
    );
  }
}

Widget buildTransaction(BuildContext context, ProductAddressModel transaction) {
  return Card(
    color: Colors.white,
    child: ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      title: Text(
        transaction.productName,
        maxLines: 1,
        overflow: TextOverflow.clip,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      //subtitle: Text(trans),
      trailing: Text(
        transaction.qty.toString(),
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 22),
      ),
      children: [
        buildButtons(context, transaction),
      ],
    ),
  );
}

Widget buildButtons(BuildContext context, ProductAddressModel transaction) =>
    Row(
      children: [
        Expanded(
          child: TextButton.icon(
            label: Text('Edit'),
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TransactionDialog(
                    transaction: transaction,
                    onClickedDone: (name, qty) =>
                        HiveServices.editTransaction(transaction, name, qty)
                    //editTransaction(transaction, name, amount, isExpense),
                    ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            label: Text('Delete'),
            icon: Icon(Icons.delete),
            onPressed: () => HiveServices.deleteTransaction(transaction),
          ),
        )
      ],
    );
