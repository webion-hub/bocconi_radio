import 'package:audio_service/audio_service.dart';
import 'package:bocconi_radio/dependency_injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class PodcastPage extends StatelessWidget {
  final _audioHandler = getIt<AudioHandler>();
  
  PodcastPage({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Show media item title
          StreamBuilder<MediaItem?>(
            stream: _audioHandler.mediaItem,
            builder: (context, snapshot) {
              final mediaItem = snapshot.data;
              return Text(mediaItem?.title ?? '');
            },
          ),
          // Play/pause/stop buttons.
          StreamBuilder<bool>(
            stream: _audioHandler
              .playbackState
              .map((state) => state.playing)
              .distinct(),

            builder: (context, snapshot) {
              final playing =
                snapshot.data ?? false;
              
              return _controlButtons(playing); 
            },
          ),
          // Display the processing state.
          StreamBuilder<AudioProcessingState>(
            stream: _audioHandler
              .playbackState
              .map((state) => state.processingState)
              .distinct(),
            
            builder: (context, snapshot) {
              final processingState =
                snapshot.data ?? AudioProcessingState.idle;
              
              return Text(
                'Processing state: ${describeEnum(processingState)}'
              );
            },
          ),
        ],
      ),
    );
  }


  Widget _controlButtons(bool playing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _button(Icons.fast_rewind, _audioHandler.rewind),
        _playOrPauseButton(playing),
        _button(Icons.stop, _audioHandler.stop),
        _button(Icons.fast_forward, _audioHandler.fastForward),
      ],
    );
  }

  Widget _playOrPauseButton(bool playing) {
    return playing
      ? _button(Icons.pause, _audioHandler.pause)
      : _button(Icons.play_arrow, _audioHandler.play);
  }

  IconButton _button(IconData iconData, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(iconData),
      iconSize: 64.0,
      onPressed: onPressed,
    );
  }
}
