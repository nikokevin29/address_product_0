part of 'pages.dart';

// ignore: must_be_immutable
class Tabs extends StatefulWidget {
  var bottomNavBarIndex;

  Tabs({this.bottomNavBarIndex = 0});

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  int bottomNavBarIndex = 0;
  late TabController controller;
  late ScrollController _scrollViewController;
  late DateTime currentBackPressTime;
  @override
  void initState() {
    controller = new TabController(
        length: 3, vsync: this, initialIndex: widget.bottomNavBarIndex);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    super.initState();
  }



  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) < Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.snackbar('Exit ?', 'Tap Exit Again for Exit');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void dispose() {
    //Hive.box('transaction').close();
    controller.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: new Material(
        color: Colors.white,
        child: TabBar(
          controller: controller,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
          labelStyle: TextStyle(color: Colors.black),
          onTap: (index) {
            setState(() {
              widget.bottomNavBarIndex = index;
            });
          },
          tabs: [
            Tab(
              icon: FaIcon(FontAwesomeIcons.home),
              text: 'Beranda',
            ),
            Tab(
              icon: FaIcon(FontAwesomeIcons.smoking),
              text: 'Rokok',
            ),
            Tab(
              icon: FaIcon(FontAwesomeIcons.addressBook),
              text: 'Alamat',
            ),
          ],
        ),
      ),
      body: WillPopScope(
          onWillPop: onWillPop,
          child: TabBarView(controller: controller, children: [
            DashboardPage(),
            CigarettesPage(),
            AddressPage(controller: controller),
          ])),
    );
  }
}
