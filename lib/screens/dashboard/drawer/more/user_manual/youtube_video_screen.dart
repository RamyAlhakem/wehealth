import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YouTubeVideoScreen extends StatefulWidget {
  const YouTubeVideoScreen({Key? key, required this.videoId}) : super(key: key);
  final String videoId;

  @override
  State<YouTubeVideoScreen> createState() => _YouTubeVideoScreenState();
}

class _YouTubeVideoScreenState extends State<YouTubeVideoScreen> {
  late final YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = YoutubePlayerController.fromVideoId(
        videoId: widget.videoId, autoPlay: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: YoutubePlayerScaffold(
          builder: (context, player) => player, controller: _controller),
    );
  }
}
