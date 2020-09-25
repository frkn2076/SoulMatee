import 'package:flutter/material.dart';

import 'login.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        // '/detail': (context) => Detail(ModalRoute.of(context).settings.arguments),
        '/login': (context) => Login()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardHomePage(),
    );
  }
}

class DashboardHomePage extends StatefulWidget {
  DashboardHomePage() : super();

  @override
  _DashboardHomePageState createState() => _DashboardHomePageState();
}

class _DashboardHomePageState extends State<DashboardHomePage> {
  bool isSearchAppBar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 150.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () =>
                Navigator.pushNamed(context, '/login'),
          ),
        ),
        body: Container(child: Text("deneme")));
  }
}
