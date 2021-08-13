part of 'pages.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Tabs();
          } else if (snapshot.hasError) {
            return Center(child: Text('Something Went wrong!'));
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
