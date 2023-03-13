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
  List numList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  List symbolList = ["C", "+", "-", "/2", "=", "Del"];
  dynamic newNum = "";
  dynamic proc = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context, widget.currentHp);
              },
              child: Icon(Icons.ios_share),
            ),
            body: Stack(clipBehavior: Clip.none, children: [
              Positioned(
                  top: 0.0,
                  left: 0.0,
                  child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.black,
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.close)))),
              Container(
                  color: Colors.amberAccent,
                  child: Column(children: [
                    Row(
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
                              itemCount: numList.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          newNum += numList[index];
                                          print(newNum);
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
                                          case "/2":
                                            setState(() {
                                              proc = "/";
                                              newNum = "2";
                                            });
                                            break;
                                          case "=":
                                            setState(() {
                                              widget.currentHp = resolveEqq(
                                                  widget.currentHp,
                                                  newNum,
                                                  proc);
                                              newNum = "";
                                              proc = "";
                                            });
                                            break;
                                        }
                                      },
                                      child: Text(symbolList[index])),
                                );
                              }),
                              itemCount: symbolList.length),
                        ),
                      ],
                    )
                  ])),
            ])));
  }
}

resolveEqq(String lp, String newNum, String proc) {
  switch (proc) {
    case "+":
      return "${int.parse(lp) + int.parse(newNum)}";

    case "-":
      return "${int.parse(lp) - int.parse(newNum)}";

    case "/":
      return "${int.parse(lp) ~/ 2}";
  }
}
