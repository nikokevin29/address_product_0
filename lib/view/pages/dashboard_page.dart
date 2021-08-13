part of 'pages.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final user = FirebaseAuth.instance.currentUser;
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
          ],
        ),
      )),
    );
  }
}
