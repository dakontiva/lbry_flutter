import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class LbryVideoPlayer extends StatefulWidget {
  const LbryVideoPlayer({Key? key, required this.streamingUrl}) : super(key: key);
  final String streamingUrl;

  @override
  _LbryVideoPlayerState createState() => _LbryVideoPlayerState();
}

class _LbryVideoPlayerState extends State<LbryVideoPlayer> {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;

  @override
  void initState() {
    super.initState();
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
      child: BetterPlayer(controller: _betterPlayerController),
    );
  }
}


