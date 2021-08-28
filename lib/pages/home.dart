import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lbry/widgets/claim_tile.dart';

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
    var url = Uri.parse('http://10.0.2.2:5279');
    // var url = Uri.parse('http://127.0.0.1:5279');
    var response = await http.post(url,
        body: json.encode({
          "method": "claim_search",
          "params": {
            "order_by": "effective_amount",
            "claim_type": "stream",
            "page": currentPage,
            "page_size": 20,
            "no_totals": true,
            "remomve_duplicates": true,
          }
        }));
    currentPage += 1;
    // print(json.decode(response.body)["result"]["items"].runtimeType);
    claimList.addAll(json.decode(response.body)["result"]["items"]);
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
        title: Text('LBRY'),
        centerTitle: true,
        backgroundColor: Colors.green,
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
                        "thumbnail_url": claimList[index]["value"]["thumbnail"]["url"],
                        "channel_name": (claimList[index]["signing_channel"] == null) ? "Anonymous" : claimList[index]["signing_channel"]["name"],
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
                            color: Colors.black,
                          ),
                        ),
                      ))
                ]
              ],
            );
        },
      ),
    );
    ;
  }
}
