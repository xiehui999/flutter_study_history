import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({Key key, this.labelId}) : super(key: key);

  final String labelId;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('收藏页面'),
      ),
    );
  }
}
