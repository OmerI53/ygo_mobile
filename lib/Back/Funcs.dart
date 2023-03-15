import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

//Card Classes
class YGOCard {
  String name = '';
  String type = '';
  String eff = '';

  YGOCard(this.name, this.type, this.eff);

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'eff': eff,
      };
}

class SpellCard extends YGOCard {
  String race = '';
  SpellCard(super.name, super.type, super.eff, this.race);

  SpellCard.fromJson(Map<String, dynamic> json)
      : race = json['race'],
        super(json['name'], json['type'], json['eff']);

  @override
  Map<String, dynamic> toJson() =>
      {'name': name, 'type': type, 'eff': eff, 'race': race};
}

class TrapCard extends YGOCard {
  String race = '';
  TrapCard(super.name, super.type, super.eff, this.race);

  TrapCard.fromJson(Map<String, dynamic> json)
      : race = json['race'],
        super(json['name'], json['type'], json['eff']);

  @override
  Map<String, dynamic> toJson() =>
      {'name': name, 'type': type, 'eff': eff, 'race': race};
}

class MonsterCard extends YGOCard {
  String monsterType = '';
  int lvlRankLink;
  String attr = '';
  String race = '';
  int atk;
  int def;

  MonsterCard(super.name, super.type, super.eff, this.monsterType, this.race,
      this.attr, this.lvlRankLink, this.atk, this.def);

  MonsterCard.fromJson(Map<String, dynamic> json)
      : monsterType = json['monsterType'],
        lvlRankLink = json['lvlRankLink'],
        race = json['race'],
        atk = json['atk'],
        def = json['def'],
        attr = json['attr'],
        super(json['name'], json['type'], json['eff']);
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

  getCardInfo() {
    return '$name,$type,$eff,';
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
Future<Map> getCards(String jsonString, String searchKey) async {
  Map matchMap = {};
  Map<String, dynamic> nameDesc = json.decode(jsonString);
  for (var key in nameDesc.keys) {
    if (key.contains(searchKey)) {
      matchMap[key] = nameDesc[key];
    }
  }
  return matchMap;
}

void main(List<String> args) {
  //getCardDatabase();
}
