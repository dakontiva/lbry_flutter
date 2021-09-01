import 'package:flutter/material.dart';
import 'package:lbry/widgets/lbry_video_player.dart';
import 'package:lbry/services/lbry_sdk/main.dart' as lbry_sdk_main;

class ShowClaim extends StatefulWidget {
  const ShowClaim({Key? key}) : super(key: key);

  @override
  _ShowClaimState createState() => _ShowClaimState();
}

class _ShowClaimState extends State<ShowClaim> {
  late final Future<String> streamingUrl;

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
    streamingUrl = lbry_sdk_main.get(claimProps["permanent_url"]);
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
                child = LbryVideoPlayer(streamingUrl: '${snapshot.data}');
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
