import 'package:bocconi_radio/blog/post.dart' as blog;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PostPreview extends StatelessWidget {
  final blog.Post post;
  
  const PostPreview.from(this.post, {
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _getCover(),
          _getPublishDate(),
          Text(post.description),
        ],
      ),
    );
  }


  Widget _getCover() {
    return post.hasImage
      ? Image.network(post.imageUrl!)
      : const SizedBox.shrink();
  }

  Widget _getPublishDate() {
    return post.hasPublishDate
      ? Text(post.publishDate!.toString())
      : const SizedBox.shrink();
  }
}