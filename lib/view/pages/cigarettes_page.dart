part of 'pages.dart';

class CigarettesPage extends StatefulWidget {
  const CigarettesPage({Key? key}) : super(key: key);

  @override
  _CigarettesPageState createState() => _CigarettesPageState();
}

class _CigarettesPageState extends State<CigarettesPage> {
  TextEditingController productName = TextEditingController();
  TextEditingController productStock = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getUsersPastTripsStreamSnapshots();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var tripSnapshot in _allResults) {
        var title = ProductModel.fromSnapshot(tripSnapshot).name.toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(tripSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getUsersPastTripsStreamSnapshots() async {
    var data = await FirebaseFirestore.instance.collection('product').get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return "complete";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stok Rokok'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefix: Icon(Icons.search),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: _resultsList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildCard(context, _resultsList[index])),
              // StreamBuilder<QuerySnapshot>(
              //   stream: FirebaseFirestore.instance
              //       .collection('product')
              //       .snapshots(),
              //   builder: (context, snapshot) {
              //     if (!snapshot.hasData) {
              //       return Center(child: CircularProgressIndicator());
              //     } else {
              //       return ListView.builder(
              //           shrinkWrap: true,
              //           physics: ClampingScrollPhysics(),
              //           itemCount: snapshot.data!.docs.length,
              //           itemBuilder: (context, index) {
              //             return Card(
              //               child: ListTile(
              //                 onLongPress: () => showDialog<String>(
              //                   context: context,
              //                   builder: (BuildContext context) => AlertDialog(
              //                     title: const Text('Hapus Produk'),
              //                     content: const Text(
              //                         'Apakah anda yakin ingin menghapus produk ini ?'),
              //                     actions: <Widget>[
              //                       TextButton(
              //                         onPressed: () =>
              //                             Navigator.pop(context, 'Cancel'),
              //                         child: const Text('Batal'),
              //                       ),
              //                       TextButton(
              //                         onPressed: () {
              //                           FirebaseFunction.deleteProduct(
              //                               id: snapshot.data!.docs[index].id);
              //                           Navigator.pop(context, 'OK');
              //                         },
              //                         child: const Text('Ya'),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 title: Text(snapshot.data!.docs[index]['name']),
              //                 subtitle: Text(snapshot.data!.docs[index]['stock']
              //                     .toString()),
              //                 trailing: GestureDetector(
              //                   child: Icon(Icons.edit),
              //                   onTap: () {
              //                     productName.text =
              //                         snapshot.data!.docs[index]['name'];
              //                     productStock.text = snapshot
              //                         .data!.docs[index]['stock']
              //                         .toString();
              //                     showModalBottomSheet(
              //                         context: context,
              //                         isScrollControlled: true,
              //                         builder: (BuildContext context) {
              //                           return Padding(
              //                             padding:
              //                                 MediaQuery.of(context).viewInsets,
              //                             child: Container(
              //                               height: 200,
              //                               color: Colors.white38,
              //                               child: Padding(
              //                                 padding:
              //                                     const EdgeInsets.symmetric(
              //                                         horizontal: 24),
              //                                 child: Column(
              //                                   mainAxisSize: MainAxisSize.min,
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.center,
              //                                   children: [
              //                                     TextField(
              //                                       controller: productName,
              //                                       decoration: InputDecoration(
              //                                           labelText:
              //                                               "Nama Produk"),
              //                                       autocorrect: false,
              //                                     ),
              //                                     TextField(
              //                                       controller: productStock,
              //                                       decoration: InputDecoration(
              //                                           labelText:
              //                                               "Stok Produk"),
              //                                       autocorrect: false,
              //                                       autofocus: true,
              //                                       keyboardType:
              //                                           TextInputType.number,
              //                                     ),
              //                                     SizedBox(
              //                                       height: 15,
              //                                     ),
              //                                     ElevatedButton(
              //                                       child: Text(
              //                                         'Ubah',
              //                                         style: blackTextFont
              //                                             .copyWith(
              //                                           fontSize: 22,
              //                                           color: Colors.white,
              //                                         ),
              //                                       ),
              //                                       onPressed: () {
              //                                         //Function Submit here

              //                                         FirebaseFunction
              //                                             .updateProduct(
              //                                                 id: snapshot
              //                                                     .data!
              //                                                     .docs[index]
              //                                                     .id,
              //                                                 name: productName
              //                                                     .text,
              //                                                 stock:
              //                                                     productStock
              //                                                         .text);
              //                                         Navigator.pop(context);
              //                                       },
              //                                     )
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           );
              //                         });
              //                   },
              //                 ),
              //               ),
              //             );
              //           });
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddCigarettes());
        },
        child: FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }

  buildCard(BuildContext context, DocumentSnapshot document) {
    final product = ProductModel.fromSnapshot(document);

    return Container(
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(
                product.name,
                style: blackTextFont.copyWith(fontSize: 22),
              ),
              subtitle: Text(
                product.stock.toString(),
                style: blackTextFont.copyWith(fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
