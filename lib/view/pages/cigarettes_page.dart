part of 'pages.dart';

class CigarettesPage extends StatefulWidget {
  const CigarettesPage({Key? key}) : super(key: key);

  @override
  _CigarettesPageState createState() => _CigarettesPageState();
}

class _CigarettesPageState extends State<CigarettesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stok Rokok'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('product').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView(
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Card(
                      child: ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['stock'].toString()),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddCigarettes());
        },
        child: Icon(
          Icons.plus_one,
        ),
      ),
    );
  }
}

// Widget buildItem(BuildContext context, DocumentSnapshot document) {
//   return Card(
//     child: Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: [
//           Title(
//             color: Colors.black,
//             child: Text(
//               document.data['name'],
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }
