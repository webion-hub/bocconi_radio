import 'dart:developer';

import 'package:bocconi_radio/pages/blog_preview_page.dart';
import 'package:bocconi_radio/pages/podcast_page.dart';
import 'package:bocconi_radio/pages/webcam_page.dart';
import 'package:bocconi_radio/widgets/bottom_bar.dart';
import 'package:bocconi_radio/pages/home_page.dart';
import 'package:bocconi_radio/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class App extends StatefulWidget {
  const App({ Key? key }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  BehaviorSubject<int> stream = BehaviorSubject<int>();

  @override
  Widget build(BuildContext context) {

    Widget getBody(int pageIndex){
      final widgets = {
        0: PodcastPage(),
        1: BlogPreviewPage(),
        2: WebcamPage(),
      };

      return widgets[pageIndex] ?? const HomePage();
    }

    return StreamBuilder(
      stream: stream,
      initialData: 0,
      builder: (context, AsyncSnapshot<int> snapshot){
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: const CustomAppbar(),
          bottomNavigationBar: BottomBar(
            onPressed: stream.add,
          ),
          body: getBody(snapshot.data ?? 0)
        );
      }
    );
  }
}