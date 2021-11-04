import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: (){},
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.skip_previous_rounded, size: 32),
          ),
          FloatingActionButton(
            heroTag: "home-play-button",
            child: const Icon(Icons.play_arrow_rounded, size: 28), 
            onPressed: (){},
          ),
          IconButton(
            onPressed: (){}, 
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.skip_next_rounded, size: 32),
          ),
        ],
      ),
    );
  }
}