import 'package:flutter/material.dart';

class InfiniteListView extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Function() onScrollEnd;
  final Function(BuildContext, int) itemBuilder;
  final int itemCount;

  const InfiniteListView({ 
    required this.onRefresh,
    required this.onScrollEnd,
    required this.itemBuilder,
    required this.itemCount,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(          
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          if(i >= itemCount - 6) {
            onScrollEnd();
          }

          return itemBuilder(context, i);
        }
      ),
    );
  }
}