import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

class ArticleItem extends StatelessWidget {
  final ReposModel model;
  final String labelId;
  final bool isHome;

  const ArticleItem({this.model, this.labelId, this.isHome, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        NavigatorUtil.pushWeb(context,title: model.title,url: model.link,isHome: isHome);
      },
      child: new Container(
        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
        child: new Row(
          children: <Widget>[
            new Expanded(
                child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  model.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.listTitle,
                ),
                Gaps.vGap10,
                new Text(
                  model.desc,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.listContent,
                ),
                Gaps.vGap5,
                new Row(
                  children: <Widget>[
                    new LikeBtn(
                      labelId: labelId,
                      id: model.originId ?? model.id,
                      isLike: model.collect,
                    ),
                    Gaps.hGap10,
                    new Text(
                      model.author,
                      style: TextStyles.listExtra,
                    ),
                    Gaps.hGap10,
                    new Text(
                      Utils.getTimeLine(context, model.publishTime),
                      style: TextStyles.listExtra,
                    )
                  ],
                )
              ],
            )),
            new Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 12),
              child: new CircleAvatar(
                radius: 28.0,
                backgroundColor:
                    Utils.getCircleBg(model.superChapterName ?? "公众号"),
                child: new Padding(
                  padding: EdgeInsets.all(5),
                  child: new Text(
                    model.superChapterName ?? "文章",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            )
          ],
        ),
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border.all(width: 0.33, color: AppColors.divider)),
      ),
    );
  }
}
