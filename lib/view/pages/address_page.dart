part of 'pages.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
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
              child: Icon(Icons.plus_one),
            ),
          )
        ],
      ),
    );
  }
}
