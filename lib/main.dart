import 'package:flutter/material.dart';

import 'Front/CardDb.dart';
import 'Front/DuelPage.dart';
import 'Front/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 1;
  List<Widget> pages = const [DuelPage(), HomePage(), CardDb()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomePage(),
      /*
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.gamepad), label: 'Duel'),
          NavigationDestination(icon: Icon(Icons.home), label: 'Homepage'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Cards')
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
      */
    );
    ;
  }
}
