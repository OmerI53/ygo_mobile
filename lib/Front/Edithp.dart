import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ygo_mobile/Front/DuelPage.dart';

class Edithp extends StatefulWidget {
  Edithp(this.currentHp, {super.key});
  String currentHp;

  @override
  State<Edithp> createState() => _EdithpState();
}

class _EdithpState extends State<Edithp> {
  List numList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "2*", "0", "/2"];
  List symbolList = ["C", "+", "-", "=", "Del", "GG"];
  String newNum = "    ";
  dynamic proc = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.blueAccent,
                      Colors.redAccent,
                    ],
                  ),
                ),
                child: Column(children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: Text(
                          widget.currentHp,
                          style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          shape: BoxShape.circle,
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
                        height: 50,
                        width: 50,
                        child: Text(
                          proc,
                          style: const TextStyle(fontSize: 40),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: Text(
                          newNum,
                          style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //keyboard
                    children: [
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          width: 300,
                          height: 290,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    childAspectRatio: 1.37,
                                    maxCrossAxisExtent: 100),
                            itemCount: 12,
                            itemBuilder: ((context, index) {
                              return Container(
                                padding: const EdgeInsets.all(3),
                                height: 50,
                                width: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            numList[index].length == 1
                                                ? Colors.blueGrey
                                                : Colors.redAccent,
                                        shape:
                                            const CircleBorder(eccentricity: 0),
                                        side: const BorderSide(
                                            color: Colors.black, width: 2)),
                                    onPressed: () {
                                      setState(() {
                                        if (numList[index].length == 1) {
                                          newNum += numList[index];
                                        } else {
                                          switch (numList[index]) {
                                            case "2*":
                                              proc = "*";
                                              newNum = "2";
                                              break;
                                            case "/2":
                                              proc = "/";
                                              newNum = "2";
                                          }
                                        }
                                      });
                                    },
                                    child: Text(numList[index])),
                              );
                              ;
                            }),
                          )),
                      Container(
                        width: 200,
                        height: 250,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(1),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  childAspectRatio: 1.25,
                                  maxCrossAxisExtent: 120),
                          itemCount: symbolList.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              padding: const EdgeInsets.all(3),
                              height: 60,
                              width: 60,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      shape:
                                          const CircleBorder(eccentricity: 0),
                                      side: const BorderSide(
                                          color: Colors.black, width: 2)),
                                  onPressed: () {
                                    switch (symbolList[index]) {
                                      case "C":
                                        setState(() {
                                          newNum = "";
                                        });
                                        break;
                                      case "+":
                                        setState(() {
                                          proc = "+";
                                        });
                                        break;
                                      case "-":
                                        setState(() {
                                          proc = "-";
                                        });
                                        break;
                                      case "=":
                                        setState(() {
                                          if (newNum.isNotEmpty) {
                                            widget.currentHp = resolveEqq(
                                                widget.currentHp, newNum, proc);
                                            newNum = "";
                                            proc = "";
                                          }
                                        });
                                        break;
                                      case "Del":
                                        setState(() {
                                          if (newNum.isNotEmpty) {
                                            newNum = newNum.substring(
                                                0, newNum.length - 1);
                                          }
                                        });
                                        break;
                                      case "GG":
                                        setState(() {
                                          widget.currentHp = "0";
                                        });
                                        break;
                                    }
                                  },
                                  child: Text(symbolList[index])),
                            );
                          }),
                        ),
                      ),
                    ],
                  )
                ])),
            Positioned(
                top: 20.0,
                left: 20.0,
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(13),
                          shape: const CircleBorder(
                            side: BorderSide(color: Colors.black, width: 2),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context, widget.currentHp);
                        },
                        child: const Icon(Icons.arrow_back_ios_new)))),
          ]),
    );
  }
}

resolveEqq(String lp, String newNum, String proc) {
  switch (proc) {
    case "+":
      return "${int.parse(lp) + int.parse(newNum)}";

    case "-":
      return "${int.parse(lp) - int.parse(newNum)}";

    case "/":
      return "${int.parse(lp) ~/ int.parse(newNum)}";

    case "*":
      return "${int.parse(lp) * int.parse(newNum)}";
  }
}
