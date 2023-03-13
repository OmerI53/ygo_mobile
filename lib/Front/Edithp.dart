import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Edithp extends StatefulWidget {
  Edithp(this.currentHp, {super.key});
  String currentHp;

  @override
  State<Edithp> createState() => _EdithpState();
}

class _EdithpState extends State<Edithp> {
  List numList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  String newNum = "";
  String proc = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(actions: [], title: Text(widget.currentHp)),
            body: Container(
                alignment: Alignment.center,
                color: Colors.blue,
                child: Column(children: [
                  Container(
                    color: Colors.white,
                    height: 65,
                    child: Text(
                      widget.currentHp,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      color: Colors.pink,
                      width: 300,
                      height: 250,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 4),
                        itemBuilder: ((context, index) {
                          return Keybutton(numList[index], newNum);
                        }),
                        itemCount: numList.length,
                      ))
                ]))));
  }
}

class Keybutton extends StatefulWidget {
  Keybutton(this.num, this.newNum, {super.key});

  String num;
  String newNum;
  @override
  State<Keybutton> createState() => _KeybuttonState();
}

class _KeybuttonState extends State<Keybutton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          widget.newNum += widget.num;
        },
        child: Text(widget.num));
  }
}
