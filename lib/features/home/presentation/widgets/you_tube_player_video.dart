import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerVideo extends StatefulWidget {
  const YouTubePlayerVideo({
    super.key,
  });

  @override
  State<YouTubePlayerVideo> createState() => _YouTubePlayerVideoState();
}

class _YouTubePlayerVideoState extends State<YouTubePlayerVideo> {
  late YoutubePlayerController _controller;

  String initialVideoId() {
    final language = context.read<SettingsCubit>().state.language;
    return YoutubePlayer.convertUrlToId(Environment.videoUrl(language)) ??
        'iLnmTe5Q2Qw';
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: initialVideoId(),
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

    return BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (previous, current) => previous.language != current.language,
      listener: (context, state) {
        final language = state.language;

        _controller.cue(
            YoutubePlayer.convertUrlToId(Environment.videoUrl(language)) ??
                'iLnmTe5Q2Qw');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context).translate("official_trailer"),
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
      ),
    );
  }
}
