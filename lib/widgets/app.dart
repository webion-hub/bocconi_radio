import 'package:bocconi_radio/dependency_injection.dart';
import 'package:bocconi_radio/pages/blog_preview_page.dart';
import 'package:bocconi_radio/pages/podcast_page.dart';
import 'package:bocconi_radio/widgets/bottom_bar.dart';
import 'package:bocconi_radio/pages/home_page.dart';
import 'package:bocconi_radio/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:bocconi_radio/blocs/bottom_bar_bloc.dart';

class App extends StatefulWidget {
  const App({ Key? key }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _bottomBar = getIt<BottomBarBloc>();

  @override
  Widget build(BuildContext context) {

    Widget getBody(int pageIndex){
      final widgets = {
        0: PodcastPage(),
        1: const BlogPreviewPage(),
      };

      return widgets[pageIndex] ?? const HomePage();
    }

    return StreamBuilder(
      stream: _bottomBar.indexes,
      initialData: 0,
      builder: (context, AsyncSnapshot<int> snapshot){
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: const CustomAppbar(),
          bottomNavigationBar: const BottomBar(),
          body: getBody(snapshot.data ?? _bottomBar.getLastIndex())
        );
      }
    );
  }
}