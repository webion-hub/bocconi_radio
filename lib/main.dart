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

import 'package:bocconi_radio/blog/blog.dart';
import 'package:bocconi_radio/widget/blog/post_preview.dart';
import 'package:flutter/material.dart';

import 'blog/post.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return MaterialApp(
      title: 'Blog Test',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  late final Stream<Iterable<Post>?> _posts;

  MainScreen({Key? key}) : super(key: key) {
    _posts = Stream.fromFuture(
      Blog.getPosts()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Test'),
      ),
      body: Center(
        child: StreamBuilder<Iterable<Post>?>(
          stream: _posts,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                break;

              case ConnectionState.waiting:
              default:
                return const CircularProgressIndicator();
            }

            if (!snapshot.hasData) {
              return const Text('Nothing');
            }
            
            final posts =
              snapshot.data;

            if (posts == null) {
              return const Text('Null');
            }

            if (posts.isEmpty) {
              return const Text('Empty list');
            }

            return ListView.builder(
              itemCount: posts.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return PostPreview.from(posts.elementAt(i));
              }
            );
          }
        ),
      ),
    );
  }
}