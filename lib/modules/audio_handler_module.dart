import 'package:audio_service/audio_service.dart';
import 'package:bocconi_radio/audio/podcast_player_handler.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AudioHandlerModule {
  @preResolve
  Future<AudioHandler> get handler {
    return AudioService.init(
      builder: () => PodcastPlayerHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.devpier.bocconi_radio.channel.audio',
        androidNotificationChannelName: 'Bocconi Radio',
        androidNotificationOngoing: true,
      ),
    );
  }
}