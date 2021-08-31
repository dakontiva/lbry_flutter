import 'package:http/http.dart' as http;
import 'dart:convert';


Future<String> get(String permanentUrl) async {
  Uri url = Uri.parse("http://10.0.2.2:5279");
  // Uri url = Uri.parse("http://127.0.0.1:5279");
  http.Response response = await http.post(url,
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