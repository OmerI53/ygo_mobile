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
        appBar: AppBar(
          title: const Text("duel"),
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
          ),
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
                      const Text(
                        "player 1",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        player1Hp,
                        style: const TextStyle(fontSize: 50),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      IconButton(
                        onPressed: () async {
                          player1Hp = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Edithp(player1Hp))));
                          setState(() {});
                        },
                        icon: const Icon(Icons.edit_outlined),
                      )
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
                  const Text("player 2", style: TextStyle(fontSize: 30)),
                  Text(
                    player2Hp,
                    style: const TextStyle(fontSize: 50),
                  ),
                  IconButton(
                      onPressed: () async {
                        player2Hp = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Edithp(player2Hp))));
                        setState(() {});
                      },
                      icon: const Icon(Icons.edit)),
                ],
              ),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
