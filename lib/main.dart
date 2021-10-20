import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';


late MyAudioHandler _audioHandler;


Future<void> main() async {
  _audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.devpier.bocconi_radio.channel.audio',
      androidNotificationChannelName: 'Radio Bocconi',
      androidNotificationOngoing: true,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(
        title: 'Home',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    _audioHandler.playFromUri(
      Uri.parse('https://5e302ac334abf.streamlock.net/live/live.stream/playlist.m3u8')
    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_audioHandler.playbackState.isPaused) {
              _audioHandler.play();
            } else {
              _audioHandler.pause();
            }
          });
        },
        child: Icon(
          _audioHandler.playbackState.isPaused ? Icons.play_arrow : Icons.pause,
        ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}


class MyAudioHandler 
  extends BaseAudioHandler 
  with QueueHandler, SeekHandler {
}
