import 'package:flutter/material.dart';
import 'package:invest_site/routes.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TheGorgeousLogin',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: new LoginPage(),
      routes: routes,
      initialRoute: '/',
    );
  }
}