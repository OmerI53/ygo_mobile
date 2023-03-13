import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ygo_mobile/Front/Edithp.dart';

class DuelPage extends StatefulWidget {
  const DuelPage({super.key});

  @override
  State<DuelPage> createState() => _DuelPageState();
}

class _DuelPageState extends State<DuelPage> {
  String player1Hp = "8000";
  String player2Hp = "8000";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          color: Colors.blueGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const Text("player 1"),
                      Text(
                        player1Hp,
                        style: const TextStyle(fontSize: 30),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => Edithp(player1Hp))));
                          },
                          child: const Text("edit"))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: 200,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Text("player 2"),
                  Text(
                    player2Hp,
                    style: const TextStyle(fontSize: 30),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => Edithp(player2Hp))));
                      },
                      child: const Text("edit")),
                ],
              ),
              const SizedBox(
                width: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    SystemChrome.setPreferredOrientations(
                        [DeviceOrientation.portraitUp]);
                    Navigator.of(context).pop(context);
                  },
                  child: Text("return")),
            ],
          ),
        ),
      ),
    );
  }
}
