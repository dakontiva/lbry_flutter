import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ShowClaim extends StatefulWidget {
  const ShowClaim({Key? key}) : super(key: key);

  @override
  _ShowClaimState createState() => _ShowClaimState();
}

class _ShowClaimState extends State<ShowClaim> {
  bool loading = true;

  // String streamingUrl = "";
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  Future<String> fetchData(String permanentUrl) async {
    Uri url = Uri.parse("http://10.0.2.2:5279");
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

  void initVideoPlayer(String permanentUrl) async {
    // setState(() {
    //   loading = true;
    // });
    final String streamingUrl =
        (await fetchData(permanentUrl)).replaceFirst("localhost", "10.0.2.2");
    print(streamingUrl);
    // streamingUrl = streamingUrl.replaceFirst();
    this._videoPlayerController = VideoPlayerController.network(streamingUrl);
    // this._videoPlayerController = VideoPlayerController.network(
    //     "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    await _videoPlayerController.initialize();
    this._chewieController = ChewieController(
      videoPlayerController: this._videoPlayerController,
      autoPlay: true,
      looping: true,
    );
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map claimProps = ModalRoute.of(context)!.settings.arguments as Map;
    initVideoPlayer(claimProps["permanent_url"]);
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white10,
        child: loading
            ? Center(
            child: Text(
              "loading",
              style: TextStyle(fontSize: 30),
            ))
            : Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }
}
