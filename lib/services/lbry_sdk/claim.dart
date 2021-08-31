import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> claimSearch({required int pageNumber}) async {
  final Uri url = Uri.parse('http://10.0.2.2:5279');
// var url = Uri.parse('http://127.0.0.1:5279');
  http.Response response = await http.post(url,
      body: json.encode({
        "method": "claim_search",
        "params": {
          "order_by": "effective_amount",
          "claim_type": "stream",
          "page": pageNumber,
          "page_size": 20,
          "no_totals": true,
          "remove_duplicates": true,
        }
      }));
  return json.decode(response.body)["result"]["items"];
}
