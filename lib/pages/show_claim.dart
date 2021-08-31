import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lbry/widgets/lbry_video_player.dart';

class ShowClaim extends StatefulWidget {
  const ShowClaim({Key? key}) : super(key: key);

  @override
  _ShowClaimState createState() => _ShowClaimState();
}

class _ShowClaimState extends State<ShowClaim> {
  late final Future<String> streamingUrl;

  Future<String> fetchStreamingUrl(String permanentUrl) async {
    Uri url = Uri.parse("http://10.0.2.2:5279");
    // Uri url = Uri.parse("http://127.0.0.1:5279");
    http.Response response = await http.post(url,
        body: json.encode({
          "method": "get",
          "params": {
            "uri": permanentUrl,
          }
        }));
    print(json.decode(response.body)["result"]["streaming_url"]);
    return json.decode(response.body)["result"]["streaming_url"];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map claimProps = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;
    streamingUrl = fetchStreamingUrl(claimProps["permanent_url"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LBRY'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder<String>(
            future: streamingUrl,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              Widget child;
              if(snapshot.hasData){
                child = LbryVideoPlayer(streamingUrl: '${snapshot.data?.replaceFirst("localhost", "10.0.2.2")}');
              }
              else if (snapshot.hasError){
                child = Text('${snapshot.error}');
              }
              else {
                child = CircularProgressIndicator();

              }
              return child;
            }),
    );
  }
}
