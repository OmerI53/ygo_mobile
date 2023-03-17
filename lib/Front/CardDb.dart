import 'package:flutter/material.dart';
import 'package:ygo_mobile/Back/Funcs.dart';

class CardDb extends StatefulWidget {
  const CardDb({super.key});

  @override
  State<CardDb> createState() => _CardDbState();
}

class _CardDbState extends State<CardDb> {
  TextEditingController searchController = TextEditingController();
  List matchList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: IconButton(
                          onPressed: (() async {
                            String jsonString =
                                await DefaultAssetBundle.of(context)
                                    .loadString("lib/Back/CardList.json");
                            matchList = await getCards(
                                jsonString, searchController.text);
                            setState(() {});
                          }),
                          icon: const Icon(
                            Icons.search,
                          ))),
                  controller: searchController,
                  onChanged: ((value) async {
                    setState(() {
                      if (searchController.text.isEmpty) {
                        matchList.clear();
                      }
                    });
                  }),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 300,
                  height: 550,
                  child: ListView.separated(
                    itemCount: matchList.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                          onTap: () {
                            showCard(context, matchList[index]);
                          },
                          child: CardTile(matchList[index]));
                    }),
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardTile extends StatelessWidget {
  const CardTile(this.card, {super.key});
  final YGOCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(card.borderColor)),
      height: 63,
      child: Column(children: [
        const Padding(padding: EdgeInsets.all(8)),
        Text(
          card.name,
          style: TextStyle(
              fontSize: 19,
              overflow: TextOverflow.ellipsis,
              color:
                  card.borderColor == 0xFF000000 ? Colors.white : Colors.black),
          textAlign: TextAlign.center,
        ),
        Text(
          card.type,
          style: TextStyle(
              fontSize: 13,
              color:
                  card.borderColor == 0xFF000000 ? Colors.white : Colors.black),
        )
      ]),
    );
  }
}

showCard(BuildContext context, YGOCard card) {
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.purpleAccent,
                  Colors.yellow,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            width: 340,
            height: 550,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  //Card name
                  Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 72,
                      width: 290,
                      child: Text(
                        card.name,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(
                    height: 140,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 280,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      //Card info field
                      child: Text(
                        card.getInfoFields(),
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Effect Bar
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 220,
                    width: 320,
                    child: SingleChildScrollView(
                      child: Text(card.eff,
                          style: const TextStyle(fontSize: 15),
                          textAlign: TextAlign.center),
                    ),
                  )
                ]),
          ),
        );
      });
}
