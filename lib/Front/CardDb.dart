import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ygo_mobile/Back/Funcs.dart';
import 'package:http/http.dart' as http;

class CardDb extends StatefulWidget {
  const CardDb({super.key});

  @override
  State<CardDb> createState() => _CardDbState();
}

class _CardDbState extends State<CardDb> {
  TextEditingController searchController = TextEditingController();
  Map matchList = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.yellow,
              Colors.purpleAccent,
            ],
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                    hintText: 'Search', suffixIcon: Icon(Icons.search)),
                controller: searchController,
                onChanged: ((value) async {
                  setState(() {});
                }),
              ),
              ElevatedButton(
                  onPressed: (() async {
                    String jsonString = await DefaultAssetBundle.of(context)
                        .loadString("lib/Back/nameDesc.json");

                    matchList = await getCards(jsonString, "Mathmech");
                    print(matchList.keys);
                    setState(() {});
                  }),
                  child: const Icon(Icons.search)),
              Container(
                color: Colors.white,
                width: 300,
                height: 500,
                child: ListView.builder(
                    itemCount: matchList.length,
                    itemBuilder: ((context, index) {
                      return CardTile(matchList.keys.elementAt(index),
                          matchList.values.elementAt(index));
                    })),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardTile extends StatefulWidget {
  CardTile(this.name, this.effect, {super.key});
  String name;
  String effect;

  @override
  State<CardTile> createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      width: 300,
      height: 400,
      child: Column(children: [
        Text(
          widget.name,
          style: TextStyle(fontSize: 10),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(widget.effect, style: TextStyle(fontSize: 10))
      ]),
    );
  }
}
