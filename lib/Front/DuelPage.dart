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
  int time = const Duration(minutes: 40).inSeconds;
  Timer? myTimer;
  bool timerActive = false;

  _startTimer() {
    if (!timerActive) {
      myTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          time--;
        });
      });
      timerActive = true;
    }
  }

  _stopTimer() {
    if (timerActive) {
      myTimer?.cancel();
      timerActive = false;
    }
  }

  _resetState() {
    setState(() {
      player1Hp = "8000";
      player2Hp = "8000";
      _stopTimer();
      time = const Duration(minutes: 40).inSeconds;
    });
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
                  const SizedBox(
                    width: 60,
                  ),
                  //Player 1 Column
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const Text(
                        "Player 1",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        player1Hp,
                        style: const TextStyle(fontSize: 60),
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
                width: 100,
              ),
              //Timer Column
              Column(
                children: [
                  const Padding(padding: EdgeInsets.all(15)),
                  Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              color: Colors.transparent),
                          width: 150,
                          height: 50,
                          child: Text(
                            "${Duration(seconds: time).inMinutes}:${Duration(seconds: time.remainder(60).remainder(60)).inSeconds}",
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          )),
                      Row(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  shape: const CircleBorder()),
                              onPressed: (() {
                                _startTimer();
                              }),
                              child: const Icon(
                                Icons.play_arrow,
                              )),
                          const SizedBox(
                            width: 2,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey,
                                  shape: const CircleBorder()),
                              onPressed: (() {
                                setState(() {
                                  _stopTimer();
                                });
                              }),
                              child: const Icon(Icons.stop))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 160,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.black, width: 2),
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100))),
                      onPressed: () {
                        _resetState();
                      },
                      child:
                          const Text("Reset", style: TextStyle(fontSize: 23)))
                ],
              ),
              const SizedBox(
                width: 100,
              ),
              //Player 2 Column
              Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Text("Player 2", style: TextStyle(fontSize: 30)),
                  Text(
                    player2Hp,
                    style: const TextStyle(fontSize: 60),
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
                        setState(() {
                          _resetState();
                          Navigator.pop(context);
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.portraitUp]);
                        });
                      },
                      child: const Icon(Icons.arrow_back_ios_new)),
                )))
      ]),
    );
  }
}
