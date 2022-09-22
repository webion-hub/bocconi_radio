import 'package:bocconi_radio/pages/info_page.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget{
  const CustomAppbar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "appbar",
      child: AppBar(
        title: Column(
          children: [
            const Text('Radio Bocconi'),
            Text(
              'Powered by Webion Srl', 
              style: Theme.of(context).textTheme.caption,
            ),
          ]
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_rounded),
            onPressed: (){
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16), 
                    topRight: Radius.circular(16)
                  )
                ),
                context: context,
                builder: (BuildContext context) {
                  return const InfoPage();
                },
              );
            }, 
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}