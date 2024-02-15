import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/api/get_trailer_link.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchTrailer extends ConsumerStatefulWidget {
  const WatchTrailer({super.key});

  @override
  ConsumerState<WatchTrailer> createState() => _WatchTrailerState();
}

class _WatchTrailerState extends ConsumerState<WatchTrailer> {
  late YoutubePlayerController controller;
  String? videoKey;

  @override
  void initState() {
    super.initState();
    videoSetup();
  }

  void videoSetup() async {
    // getting trailer youtube video key
    videoKey = await getTrailerVideoKey(movieProvider.id.toString());

    // setting up controller
    controller = YoutubePlayerController(
      initialVideoId: videoKey!,
      flags: const YoutubePlayerFlags(
        loop: false,
        autoPlay: true,
        controlsVisibleAtStart: false,
        enableCaption: false,
        hideThumbnail: true,
      ),
    );

    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    if (videoKey != null) {
      return Scaffold(
        extendBody: true,
        body: Center(
          child: YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
            onEnded: (metaData) {
              Navigator.pop(context);
              if (MediaQuery.of(context).size.width > 600) {
                controller.toggleFullScreenMode();
              }
            },
            progressColors: const ProgressBarColors(
              playedColor: Colors.red,
            ),
          ),
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
