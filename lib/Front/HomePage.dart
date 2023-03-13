import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ygo_mobile/Front/CardDb.dart';
import 'package:ygo_mobile/Front/DuelPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          color: Colors.purple,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                onPressed: () {
                  SystemChrome.setPreferredOrientations(
                      [DeviceOrientation.landscapeRight]);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const DuelPage())));
                },
                child: const Text("Duel")),
          ])),
    );
  }
}
