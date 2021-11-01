import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';

class LbryVideoPlayer extends StatefulWidget {
  const LbryVideoPlayer({Key? key, required this.streamingUrl}) : super(key: key);
  final String streamingUrl;

  @override
  _LbryVideoPlayerState createState() => _LbryVideoPlayerState();
}

class _LbryVideoPlayerState extends State<LbryVideoPlayer> {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;
  
  // late final VideoPlayerController _videoPlayerController;
  // late final ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initVideoPlayer();
  }

  void initVideoPlayer() {

    // _videoPlayerController = VideoPlayerController.network(widget.streamingUrl, formatHint: VideoFormat.hls,);
    // // _videoPlayerController.initialize();

    // _chewieController = ChewieController(
    //   videoPlayerController: _videoPlayerController,
    //   autoPlay: true,
    //   looping: true,
    //   aspectRatio: 16 /9,
    //   allowFullScreen: true,
    // );


    BetterPlayerConfiguration betterPlayerConfiguration =
    BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
      autoDetectFullscreenDeviceOrientation: true,
    );
    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.streamingUrl,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(controller: _betterPlayerController,)
    );
  }

  // @override
  // void dispose() {
  //   _videoPlayerController.dispose();
  //   _chewieController.dispose();
  //   super.dispose();
  // }
}


