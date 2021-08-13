part of 'pages.dart';

class AddCigarettes extends StatefulWidget {
  const AddCigarettes({Key? key}) : super(key: key);

  @override
  _AddCigarettesState createState() => _AddCigarettesState();
}

class _AddCigarettesState extends State<AddCigarettes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Rokok Baru'),
      ),
    );
  }
}
