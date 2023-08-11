import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/constants/environment.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerVideo extends StatefulWidget {
  const TrailerVideo({
    super.key,
  });

  @override
  State<TrailerVideo> createState() => _TrailerVideoState();
}

class _TrailerVideoState extends State<TrailerVideo> {
  String videoId =
      YoutubePlayer.convertUrlToId(Environment.videoUrl) ?? 'iLnmTe5Q2Qw';

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Text(
            "Trailer oficial",
            style: textStyle,
          ),
          const SizedBox(
            height: 10.0,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: YoutubePlayer(
              controller: _controller,
            ),
          ),
        ],
      ),
    );
  }
}
