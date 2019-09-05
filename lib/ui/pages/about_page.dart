import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

class AboutPage extends StatelessWidget {
  ComModel github = new ComModel(
      title: 'GitHub', url: 'https://github.com/xiehui999', extra: 'Go Star');
  ComModel author = new ComModel(
      title: '简书', url: 'https://www.jianshu.com/u/d5b531888b2b', extra: '查看');
  ComModel weibo = new ComModel(
      title: '微博', url: 'https://weibo.com/745687294', extra: '问问题');

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(IntlUtil.getString(context, Ids.titleAbout)),
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            height: 160,
            alignment: Alignment.center,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: new Image.asset(
                    Utils.getImgPath('ali_connors'),
                    width: 72,
                    height: 72,
                    fit: BoxFit.fill,
                  ),
                ),
                Gaps.vGap10,
                new Text(
                  '版本号${AppConfig.version}',
                  style: new TextStyle(color: AppColors.gray_99, fontSize: 14),
                )
              ],
            ),
            decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border.all(width: 0.33, color: AppColors.divider)),
          ),
          new ArrowItem(github),
          new ArrowItem(author),
          new ArrowItem(weibo),
        ],
      ),
    );
  }
}
