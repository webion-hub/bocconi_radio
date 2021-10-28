import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.of(context).pushNamed('/blog');
          }, 
          child: const Text("blog")
        ),
      ),
    );
  }
}