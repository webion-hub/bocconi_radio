import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';


class RadioPlayerHandler extends BaseAudioHandler with SeekHandler {
  static const _item = MediaItem(
    id: 'https://5e302ac334abf.streamlock.net/live/live.stream/playlist.m3u8',
    title: "Podcast | Radio bocconi",
  );

  final _player = AudioPlayer();

  RadioPlayerHandler() {
    _player
      .playbackEventStream
      .map(_transformEvent)
      .pipe(playbackState);

    mediaItem.add(_item);
    _setAudioSource();
  }

  void _setAudioSource() {
    _player.setAudioSource(
      AudioSource.uri(
        Uri.parse(_item.id)
      )
    );
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();


  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        _player.playing
          ? MediaControl.pause
          : MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}