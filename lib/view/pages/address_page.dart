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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      //
                    },
                    child: Text('Kosongkan'),
                  ),
                  TextButton(
                    onPressed: () {
                      //
                    },
                    child: Text('Print'),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(SearchMinyak());
                    },
                    child: Text('Cari Barang'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
