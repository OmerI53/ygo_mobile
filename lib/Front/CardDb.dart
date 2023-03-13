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
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                hintText: 'Search', suffixIcon: Icon(Icons.search)),
            onChanged: ((value) {}),
          ),
        ],
      ),
    );
  }
}
