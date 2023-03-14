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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.red,
                Colors.blue,
              ],
            ),
          ),
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "Images/logo.png",
              height: 160,
            ),
            const SizedBox(
              height: 200,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Colors.black, width: 2)),
                onPressed: () {
                  SystemChrome.setPreferredOrientations(
                      [DeviceOrientation.landscapeRight]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const DuelPage()),
                        fullscreenDialog: true),
                  );
                },
                child: const Text(
                  "Duel",
                  style: TextStyle(fontSize: 30),
                )),
          ])),
    );
  }
}
