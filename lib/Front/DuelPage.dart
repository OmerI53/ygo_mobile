import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiver/async.dart';
import 'package:ygo_mobile/Front/Edithp.dart';

class DuelPage extends StatefulWidget {
  const DuelPage({super.key});

  @override
  State<DuelPage> createState() => _DuelPageState();
}

class _DuelPageState extends State<DuelPage> {
  String player1Hp = "8000";
  String player2Hp = "8000";
  int seconds = 60;
  Timer? myTimer;
  void _startTimer() {
    myTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds--;
      });
    });
  }

  void _stopTimer() {
    myTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(13),
                            shape: const CircleBorder(
                              side: BorderSide(color: Colors.black, width: 2),
                            ),
                            backgroundColor: Colors.transparent),
                        onPressed: () async {
                          player1Hp = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Edithp(player1Hp)),
                                  fullscreenDialog: true));
                          setState(() {});
                        },
                        child: const Icon(Icons.edit_outlined),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: 120,
              ),
              Column(
                children: [
                  const Padding(padding: EdgeInsets.all(15)),
                  Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            backgroundBlendMode: BlendMode.colorDodge,
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.red,
                                Colors.blue,
                              ],
                            ),
                          ),
                          width: 75,
                          height: 30,
                          child: Text("$seconds")),
                      Row(
                        children: [
                          Container(
                            color: Colors.pink,
                            child: ElevatedButton(
                                onPressed: (() {
                                  _startTimer();
                                }),
                                child: const Icon(Icons.play_arrow)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            color: Colors.pink,
                            child: ElevatedButton(
                                onPressed: (() {
                                  _startTimer();
                                }),
                                child: const Icon(Icons.stop)),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 250,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          player1Hp = "8000";
                          player2Hp = "8000";
                        });
                      },
                      child: const Text("Reset"))
                ],
              ),
              const SizedBox(
                width: 120,
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
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(13),
                          shape: const CircleBorder(
                            side: BorderSide(color: Colors.black, width: 2),
                          ),
                          backgroundColor: Colors.transparent),
                      onPressed: () async {
                        player2Hp = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Edithp(player2Hp)),
                                fullscreenDialog: true));
                        setState(() {});
                      },
                      child: const Icon(Icons.edit)),
                ],
              ),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
        ),
        Positioned(
            top: 20.0,
            left: 20.0,
            child: SizedBox(
                height: 50,
                width: 50,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.red,
                        Colors.blue,
                      ],
                    ),
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(13),
                          shape: const CircleBorder(
                            side: BorderSide(color: Colors.black, width: 2),
                          ),
                          backgroundColor: Colors.transparent),
                      onPressed: () {
                        Navigator.pop(context);
                        SystemChrome.setPreferredOrientations(
                            [DeviceOrientation.portraitUp]);
                      },
                      child: const Icon(Icons.arrow_back_ios_new)),
                )))
      ]),
    );
  }
}
