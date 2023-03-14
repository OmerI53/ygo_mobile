import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

_getCardDatabase() async {
  var client = http.Client();
  var url = Uri.parse('https://db.ygoprodeck.com/api/v7/cardinfo.php');
  var response = await client.get(url);
  if (response.statusCode == 200) {
    //WRITE ID-NAME PAIR
    var nameDesc = {};
    var data = json.decode(response.body);
    List cardlist = data['data'];
    for (var i in cardlist) {
      String name = i['name'];
      nameDesc[name] = i['desc'];
    }
    File idnamef = File('lib/Back/nameDesc.json');
    idnamef.writeAsString(jsonEncode(nameDesc));
  } else {
    print("error from api");
  }
  client.close();
}

void main(List<String> args) {
  _getCardDatabase();
}
