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
  List numList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*2", "0", "/2"];
  List symbolList = ["C", "+", "-", "=", "Del"];
  String newNum = "";
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
                color: Colors.amberAccent,
                child: Column(children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.white,
                        height: 65,
                        width: 150,
                        child: Text(
                          widget.currentHp,
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                      Container(
                        color: Colors.orangeAccent,
                        height: 65,
                        width: 150,
                        child: Text(
                          proc,
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                      Container(
                        color: Colors.green,
                        height: 65,
                        width: 150,
                        child: Text(
                          newNum,
                          style: const TextStyle(fontSize: 40),
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
                          color: Colors.pink,
                          width: 300,
                          height: 250,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    childAspectRatio: 2,
                                    maxCrossAxisExtent: 100),
                            itemCount: 12,
                            itemBuilder: ((context, index) {
                              return Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                                child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (numList[index].length == 1) {
                                          newNum += numList[index];
                                        } else {
                                          switch (numList[index]) {
                                            case "*2":
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
                        width: 100,
                        height: 250,
                        color: Colors.green,
                        child: ListView.builder(
                            itemBuilder: ((context, index) {
                              return Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                                child: ElevatedButton(
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
                                            widget.currentHp = resolveEqq(
                                                widget.currentHp, newNum, proc);
                                            newNum = "";
                                            proc = "";
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
                                      }
                                    },
                                    child: Text(symbolList[index])),
                              );
                            }),
                            itemCount: 5),
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
