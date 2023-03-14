import 'package:flutter/material.dart';

class CardDb extends StatefulWidget {
  const CardDb({super.key});

  @override
  State<CardDb> createState() => _CardDbState();
}

class _CardDbState extends State<CardDb> {
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
                onChanged: ((value) {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
