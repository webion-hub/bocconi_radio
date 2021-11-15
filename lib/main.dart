// ignore_for_file: public_member_api_docs

// FOR MORE EXAMPLES, VISIT THE GITHUB REPOSITORY AT:
//
//  https://github.com/ryanheise/audio_service
//
// This example implements a minimal audio handler that renders the current
// media item and playback state to the system notification and responds to 4
// media actions:
//
// - play
// - pause
// - seek
// - stop
//
// To run this example, use:
//
// flutter run

import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:bocconi_radio/pages/podcast_page.dart';
import 'package:flutter/material.dart';

import 'audio/podcast_player_handler.dart';

Future<void> main() async {
  audioHandler = await AudioService.init(
    builder: () => PodcastPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.devpier.bocconi_radio.channel.audio',
      androidNotificationChannelName: 'Bocconi Radio',
      androidNotificationOngoing: true,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Service Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PodcastPage(),
    );
  }
}
