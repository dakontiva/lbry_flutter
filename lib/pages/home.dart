import 'package:flutter/material.dart';
import 'package:lbry/services/lbry_sdk/claim.dart' as lbry_sdk_claim;
import 'package:lbry/widgets/claim_tile.dart';
import 'package:lbry/theme.dart' as theme;

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
}
