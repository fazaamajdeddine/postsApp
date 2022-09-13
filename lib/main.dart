import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/pages/home_page.dart';
import 'package:providerapp/providers/homePageProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Provider REST',
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (context) => HomePAgeProvider(),
        child: HomePage()),
    );
  }
}

