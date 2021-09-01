import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lbry/consts.dart' as lbry_consts;


Future<String> get(String permanentUrl) async {
  final Uri apiUrl = Uri.https(lbry_consts.LBRY_API_AUTHORITY, lbry_consts.LBRY_API_PATH, {"m":"get"});
  http.Response response = await http.post(apiUrl,
      body: json.encode({
        "method": "get",
        "params": {
          "uri": permanentUrl,
          "save_file": false,
        }
      }));
  print(json.decode(response.body)["result"]["streaming_url"]);
  return json.decode(response.body)["result"]["streaming_url"];
}