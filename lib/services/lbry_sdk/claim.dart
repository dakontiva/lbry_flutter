import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lbry/consts.dart' as lbry_consts;

Future<List> claimSearch({required int pageNumber}) async {
  final Uri apiUrl = Uri.https(lbry_consts.LBRY_API_AUTHORITY, lbry_consts.LBRY_API_PATH, {"m":"claim_search"});
  http.Response response = await http.post(apiUrl,
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
