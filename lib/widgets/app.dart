import 'package:bocconi_radio/pages/blog_page.dart';
import 'package:bocconi_radio/pages/webcam_page.dart';
import 'package:bocconi_radio/widgets/bottom_bar.dart';
import 'package:bocconi_radio/pages/home_page.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {

  const App({
    Key? key
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  String currentRoute = '/';

  void updateCurrentRoute(String newRoute){
    setState(() {
      currentRoute = newRoute;
    });
  }

  @override
  Widget build(BuildContext context) {
    const String initialRoute = '/';

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.height * 0.17,
        width: MediaQuery.of(context).size.width * 0.17,
        child: FloatingActionButton(
          child: const Icon(Icons.mic_rounded, size: 28), 
          onPressed: () {
            _navigatorKey.currentState?.pushNamed("/");
          },
        )
      ),
      bottomNavigationBar: BottomBar(
        navigatorKey: _navigatorKey,
        currentRoute: currentRoute,
      ),
      appBar: AppBar(),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          String route = settings.name ?? initialRoute;

          return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              const routes = {
                '/webcam': WebcamPage(),
                '/blog':   BlogPage(),
                '/':       HomePage(),
              };

              updateCurrentRoute(route);
              return routes[route] ?? const HomePage();
            },
          );
        }
      )
    );
  }
}
 