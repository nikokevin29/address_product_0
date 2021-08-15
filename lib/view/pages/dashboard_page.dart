part of 'pages.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final user = FirebaseAuth.instance.currentUser;
  DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss");
  DateRangePickerController _dateRangePickerController =
      DateRangePickerController();
  DateTime now = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // TODO: implement your code here
    setState(() {
      if (args.value is PickerDateRange) {
        startDate = DateTime.parse(
            DateFormat('dd-MM-yyyy').format(args.value.startDate));
        endDate = DateTime.parse(DateFormat('dd-MM-yyyy')
            .format(args.value.endDate ?? args.value.startDate));
        _range =
            DateFormat('dd-MM-yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd-MM-yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
    print(_range); //active
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          GestureDetector(
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Keluar'),
                content: const Text('Apakah anda yakin ingin keluar ?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.logout();
                      Navigator.pop(context, 'OK');
                    },
                    child: const Text('Ya'),
                  ),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(Icons.logout_outlined),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(user!.photoURL!),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user!.displayName!,
                      style: blackTextFont.copyWith(fontSize: 22),
                    ),
                    Text(
                      user!.email!,
                      style: blackTextFont.copyWith(fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
            Divider(),
            TextButton(
                child: Text('Date Pick'),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Column(
                            children: [
                              SfDateRangePicker(
                                onSelectionChanged: _onSelectionChanged,
                                showActionButtons: true,
                                onSubmit: (Object val) {
                                  print(startDate);
                                  print(endDate);
                                },
                                onCancel: () {
                                  //_dateRangePickerController.selectedRanges = null;
                                  Get.back();
                                },
                                //controller: _dateRangePickerController,
                                selectionMode:
                                    DateRangePickerSelectionMode.range,
                              ),
                            ],
                          ),
                        );
                      });
                }),
            Divider(),
            Text('Log 3 Hari Terakhir',style:blackTextFont.copyWith(fontSize:18)),
            Divider(),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('logs')
                  // .where('created_at',isGreaterThan: DateFormat('dd-MM-yyyy').format(startDate))
                  // .where('created_at', isLessThan: DateFormat('dd-MM-yyyy').format(endDate))
                  .orderBy('created_at', descending: true)
                  //.where('created_at', '<', endDate)
                  .where('created_at',isGreaterThanOrEqualTo: now.subtract(Duration(days: 3)))
                  .limit(50)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              ListTile(
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(dateFormat.format(snapshot
                                        .data!.docs[index]['created_at']
                                        .toDate())),
                                    Text(snapshot.data!.docs[index]['user']),
                                  ],
                                ),
                                subtitle:
                                    Text(snapshot.data!.docs[index]['action']),
                              ),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
