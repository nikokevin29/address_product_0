part of 'pages.dart';

class SearchMinyak extends StatefulWidget {
  const SearchMinyak({Key? key}) : super(key: key);

  @override
  _SearchMinyakState createState() => _SearchMinyakState();
}

class _SearchMinyakState extends State<SearchMinyak> {
  TextEditingController qtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Produk'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('product')
                  .where('stock', isEqualTo: -1)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Container(
                                        height: 200,
                                        color: Colors.white38,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 10),
                                              Text('Ambil Berapa ?',
                                                  style: blackTextFont.copyWith(
                                                      fontSize: 18)),
                                              SizedBox(height: 5),
                                              TextField(
                                                controller: qtyController,
                                                decoration: InputDecoration(
                                                    labelText: "Quantity"),
                                                autofocus: true,
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              SizedBox(height: 5),
                                              ElevatedButton(
                                                child: Text(
                                                  'Submit',
                                                  style: blackTextFont.copyWith(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  //Function Submit here
                                                  if (qtyController.text !=
                                                      '') {
                                                    //TODO: HERE
                                                    HiveServices
                                                        .addTransaction(snapshot.data!.docs[index]['name'],int.parse(qtyController.text));
                                                    Get.back();
                                                    Get.back();
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  snapshot.data!.docs[index]['name'],
                                  style: blackTextFont.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
