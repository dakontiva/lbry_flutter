import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lbry/services/lbry_sdk/claim.dart' as lbry_sdk_claim;
import 'package:lbry/widgets/claim_tile.dart';
import 'package:lbry/theme.dart' as theme;
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  List claimList = [];
  bool loading = false;
  int currentPage = 1;

  void fetchData() async {
    setState(() {
      loading = true;
    });
    List _claims = await lbry_sdk_claim.claimSearch(pageNumber: currentPage);
    currentPage += 1;
    // print(json.decode(response.body)["result"]["items"].runtimeType);
    claimList.addAll(_claims);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initUniLinks();
    fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) fetchData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LAMI'),
        centerTitle: true,
        // backgroundColor: theme.colors["background2"],
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (claimList.isEmpty)
            return Container(child: Center(child: CircularProgressIndicator()));
          else
            return Stack(
              children: [
                ListView.builder(
                    controller: _scrollController,
                    // itemExtent: 310,
                    itemCount: claimList.length,
                    itemBuilder: (context, index) {
                      return ClaimTile(claimProps: {
                        "title": claimList[index]["value"]["title"],
                        "thumbnail_url": claimList[index]["value"]["thumbnail"]
                            ["url"],
                        "channel_name":
                            (claimList[index]["signing_channel"] == null)
                                ? "Anonymous"
                                : claimList[index]["signing_channel"]["name"],
                        "permanent_url": claimList[index]["permanent_url"],
                        "channel_thumbnail_url":
                            (claimList[index]["signing_channel"] != null &&
                                    claimList[index]["signing_channel"]["value"]
                                            ["thumbnail"] !=
                                        null)
                                ? claimList[index]["signing_channel"]["value"]
                                    ["thumbnail"]["url"]
                                : "",
                        "channel_title": (claimList[index]["signing_channel"] !=
                                    null &&
                                claimList[index]["signing_channel"]["value"] !=
                                    null &&
                                claimList[index]["signing_channel"]["value"]
                                        ["title"] !=
                                    null)
                            ? claimList[index]["signing_channel"]["value"]
                                ["title"]
                            : "",
                        "release_time": claimList[index]["value"]
                            ["release_time"],
                        "description": claimList[index]["value"]["description"],
                        "timestamp": claimList[index]["timestamp"].toString(),
                      });
                    }),
                if (loading) ...[
                  Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        width: constraints.maxWidth,
                        height: 80,
                        child: Center(
                          child: CircularProgressIndicator(
                            // backgroundColor: Colors.black12,
                            color: theme.colors["background1"],
                          ),
                        ),
                      ))
                ]
              ],
            );
        },
      ),
      backgroundColor: theme.colors["background1"],
    );
  }

  late StreamSubscription _sub;

  Future<void> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        parseDeepLink(initialLink);
      }
    } on PlatformException {

    }

    _sub = linkStream.listen((String? link) {
      if (link != null) {
        parseDeepLink(link);
      }
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });
  }

  late RegExpMatch? basicMatch;
  void parseDeepLink(String link) {
    print(link);
    if (link.startsWith(RegExp("https?://odysee.com"))) {
      RegExp basicRegex = new RegExp(r'https?://odysee.com/(.+)');
      basicMatch = basicRegex.firstMatch(link);
    }

    if (basicMatch != null) {
      var urlLocation = basicMatch?.group(1);

      if (urlLocation != null) {
        RegExp canonicalRegex = new RegExp(r'(@.+)/(.+)');
        var canonicalMatch = canonicalRegex.firstMatch(urlLocation);
        if (canonicalMatch != null) {
          Navigator.pushNamed(context, '/show_claim',
              arguments: {"permanent_url": "lbry://${canonicalMatch.group(1)}/${canonicalMatch.group(2)}"}
            );
          return;
        }

        RegExp channelRegex = new RegExp(r'(@.+)');
        var channelMatch = channelRegex.firstMatch(urlLocation);
        // print("Channelmatch "+channelMatch!.group(0)!);
        if (channelMatch != null) {
          var channel = channelMatch.group(1);
          print("Tried to open channel "+channel!);
          return;
        }

        RegExp wideRegex = new RegExp(r'(.+)');
        var wideMatch = wideRegex.firstMatch(urlLocation);
        if (wideMatch != null) {
          print(wideMatch.group(1));
          Navigator.pushNamed(context, '/show_claim',
              arguments: {"permanent_url": "lbry://${wideMatch.group(1)}"}
            );
        }
      }
    }
  }
}
