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
          StreamBuilder<bool>(
            stream: _audioHandler
              .playbackState
              .map((state) => state.playing)
              .distinct(),

            builder: (context, snapshot) {
              final playing =
                snapshot.data ?? false;
              
              return _controlButtons(playing, context); 
            },
          ),
          Text(
            "Stai ascoltando ",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          StreamBuilder<MediaItem?>(
            stream: _audioHandler.mediaItem,
            builder: (context, snapshot) {
              final mediaItem = snapshot.data;
              return Text(
                mediaItem?.title ?? '',
                style: Theme.of(context).textTheme.subtitle1,
              );
            },
          ),
        ],
      )
    );
  }


  Widget _controlButtons(bool playing, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _button(Icons.fast_rewind_rounded, _audioHandler.rewind),
        _playOrPauseButton(playing, Theme.of(context).primaryColor),
        _button(Icons.fast_forward_rounded, _audioHandler.fastForward),
      ],
    );
  }

  Widget _playOrPauseButton(bool playing, Color color) {
    return playing
      ? _floatingButton(Icons.pause_rounded, _audioHandler.pause, color)
      : _floatingButton(Icons.play_arrow_rounded, _audioHandler.play, color);
  }

  Container _floatingButton(IconData iconData, VoidCallback onPressed, Color color) {
    return Container(
      margin: const EdgeInsets.all(24),
      height: 72.0,
      width: 72.0,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: color,
          child: Icon(iconData, color: Colors.white),
          onPressed: onPressed,
        ),
      ),
    );
  }

  IconButton _button(IconData iconData, VoidCallback onPressed) {
    return IconButton(
      padding: const EdgeInsets.all(0.0),
      icon: Icon(iconData),
      iconSize: 48.0,
      onPressed: onPressed,
    );
  }
}
