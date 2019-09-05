import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

class ArrowItem extends StatelessWidget {
  final ComModel model;

  const ArrowItem(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new ListTile(
        onTap: () {
          if (model.page == null) {
            NavigatorUtil.pushWeb(context,
                title: model.title, url: model.url, isHome: true);
          } else {
            NavigatorUtil.pushPage(context, model.page, pageName: model.title);
          }
        },
        title: new Text(model.title == null ? "" : model.title),
        trailing: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(
              model.extra == null ? "" : model.extra,
              style: new TextStyle(color: Colors.grey, fontSize: 14),
            ),
            new Icon(
              Icons.navigate_next,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
