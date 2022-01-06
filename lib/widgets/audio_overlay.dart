import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:bocconi_radio/dependency_injection.dart';

bool lastPlayingStatus = false;

class AudioOverlay extends StatelessWidget {
  final _audioHandler = getIt<AudioHandler>();

  AudioOverlay({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "audioOverlay",
      child: StreamBuilder<bool>(
        stream: _audioHandler
          .playbackState
          .map((state) => state.playing)
          .distinct(),

        builder: (context, snapshot) {
          final isPlaying = snapshot.data ?? lastPlayingStatus;
          lastPlayingStatus = isPlaying;

          return SizedBox(
            height: 64,
            child: Material(
              color: Theme.of(context).bottomAppBarColor,
              child: Row(
                children: [
                  _button(Icons.fast_rewind_rounded, _audioHandler.rewind),
                  _playOrPauseButton(isPlaying),
                  _button(Icons.fast_forward_rounded, _audioHandler.fastForward),

                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Radio Bocconi',
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _playOrPauseButton(bool isPlaying){
    return isPlaying
      ? _button(Icons.pause_rounded, _audioHandler.pause)
      : _button(Icons.play_arrow_rounded, _audioHandler.play);
  }

  IconButton _button(IconData iconData, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(iconData),
      onPressed: onPressed,
    );
  }
}