import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

//Card Classes
class YGOCard {
  String name = '';
  String type = '';
  String eff = '';
  int borderColor = 0;

  YGOCard(this.name, this.type, this.eff);

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'eff': eff,
      };
  getInfoFields() {
    return 'Type:$type';
  }
}

class SpellCard extends YGOCard {
  String race = '';
  int borderColor = 0xFF4CAF50;
  SpellCard(super.name, super.type, super.eff, this.race);

  SpellCard.fromJson(Map<String, dynamic> json)
      : race = json['race'],
        super(json['name'], json['type'], json['eff']);

  @override
  Map<String, dynamic> toJson() =>
      {'name': name, 'type': type, 'eff': eff, 'race': race};

  @override
  getInfoFields() {
    // TODO: implement getInfoFields
    return super.getInfoFields() + ' race:' + race;
  }
}

class TrapCard extends YGOCard {
  String race = '';
  @override
  int borderColor = 0xFFEC407A;
  TrapCard(super.name, super.type, super.eff, this.race);

  TrapCard.fromJson(Map<String, dynamic> json)
      : race = json['race'],
        super(json['name'], json['type'], json['eff']);

  @override
  Map<String, dynamic> toJson() =>
      {'name': name, 'type': type, 'eff': eff, 'race': race};
  @override
  getInfoFields() {
    // TODO: implement getInfoFields
    return super.getInfoFields() + ' race:' + race;
  }
}

class MonsterCard extends YGOCard {
  String monsterType = '';
  int lvlRankLink;
  String attr = '';
  String race = '';
  int atk;
  int def;
  @override
  int borderColor = 0xFFFF6E40;

  MonsterCard(super.name, super.type, super.eff, this.monsterType, this.race,
      this.attr, this.lvlRankLink, this.atk, this.def) {
    setBorderColor();
  }

  MonsterCard.fromJson(Map<String, dynamic> json)
      : monsterType = json['monsterType'],
        lvlRankLink = json['lvlRankLink'],
        race = json['race'],
        atk = json['atk'],
        def = json['def'],
        attr = json['attr'],
        super(json['name'], json['type'], json['eff']) {
    setBorderColor();
  }
  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'eff': eff,
        'monsterType': monsterType,
        'lvlRankLink': lvlRankLink,
        'race': race,
        'atk': atk,
        'def': def,
        'attr': attr
      };

  setBorderColor() {
    switch (type) {
      case 'Fusion Monster':
        borderColor = 0xFFAB47BC;
        break;
      case 'Synchro Monster':
        borderColor = 0xFFFAFAFA;
        break;
      case 'XYZ Monster':
        borderColor = 0xFF000000;
        break;
      case 'Link Monster':
        borderColor = 0xFF03A9F4;
        break;
      case 'Normal Monster':
        borderColor = 0xFFFFF179;
        break;
    }
  }

  @override
  getInfoFields() {
    return super.getInfoFields() +
        ' Monster Type:' +
        monsterType +
        ' Lvl/Rank/Rating:' +
        '$lvlRankLink' +
        ' attr:' +
        attr +
        ' race:' +
        race +
        ' atk: $atk, def: $def';
  }
}

//Functions
getCardDatabase() async {
  //Get all the cards from YGOprodeck'api
  var client = http.Client();
  var url = Uri.parse('https://db.ygoprodeck.com/api/v7/cardinfo.php');
  var response = await client.get(url);
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    List cardlist = data['data'];
    var allCards = {};
    //Convert the data from api to custom objects -ie Maintain relavnt information-
    for (var i in cardlist) {
      YGOCard card = YGOCard('a', 'b', 'c');
      String name = i['name'];
      String eff = i['desc'];
      String type = i['type'];

      if (type.contains('Monster')) {
        int def = i['def'] ?? 0;
        int atk = i['atk'] ?? 0;

        String linkRankLevel = '';
        if (type == 'Link Monster') {
          linkRankLevel = 'linkval';
        } else {
          linkRankLevel = 'level';
        }
        card = MonsterCard(name, type, eff, i['type'], i['race'],
            i['attribute'], i[linkRankLevel], atk, def);
      }
      if (type.contains('Spell')) {
        card = SpellCard(name, type, eff, i['race']);
      }
      if (type.contains('Trap')) {
        card = TrapCard(name, type, eff, i['race']);
      }
      allCards[name] = card.toJson();
    }
    //Write objects to json file
    File cardObj = File('lib/Back/CardList.json');
    cardObj.writeAsString(jsonEncode(allCards));
  } else {
    print("error from api");
  }
  client.close();
}

//get all the cards that contain the search key from local  json
Future<List<YGOCard>> getCards(String jsonString, String searchKey) async {
  List<YGOCard> matchList = [];
  Map<String, YGOCard> matchMap = {};
  Map<String, dynamic> jsonDecoded = json.decode(jsonString);

  for (var key in jsonDecoded.keys) {
    if (key.toLowerCase().contains(searchKey.toLowerCase())) {
      String cardType = jsonDecoded[key]['type'];
      if (cardType.contains('Monster')) {
        matchMap[key] = MonsterCard.fromJson(jsonDecoded[key]);
      }
      if (cardType.contains('Spell')) {
        matchMap[key] = SpellCard.fromJson(jsonDecoded[key]);
        if (cardType.contains('Trap')) {
          matchMap[key] = TrapCard.fromJson(jsonDecoded[key]);
        }
      }
    }
  }
  matchList = matchMap.values.toList();
  return matchList;
}

void main(List<String> args) {
  File file = File('lib/Back/Cardlist.json');
  final filecontent = file.readAsStringSync();
  //getCards(filecontent, "Mathmech");
}
