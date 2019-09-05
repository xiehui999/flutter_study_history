import 'package:flutter/material.dart';
import 'package:flutter_study_history/utils/utils.dart';

class RoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("圆角"),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(16),
        child: new Column(
          children: <Widget>[
            new ClipOval(
              child: new Image.asset(Utils.getImgPath('ali_connors')),
            ),
            new CircleAvatar(
              radius: 36,
              backgroundImage: AssetImage(Utils.getImgPath('ali_connors')),
            ),
            new Container(
                width: 72,
                height: 72,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(Utils.getImgPath('ali_connors'))))),
            new ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: new Image.asset(Utils.getImgPath('ali_connors')),
            ),
            new Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  image: DecorationImage(
                      image: AssetImage(Utils.getImgPath('ali_connors')))),
            )
          ],
        ),
      ),
    );
  }
}
