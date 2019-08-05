import 'package:base_library/base_library.dart';
import 'package:flutter_study_history/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_history/blocs/blocs_index.dart';
import 'package:flutter_study_history/utils/util_index.dart';

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new SizedBox(
        width: 24.0,
        height: 24.0,
        child: new CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}

class LikeBtn extends StatelessWidget {
  final String labelId;
  final int id;
  final bool isLike;

  const LikeBtn({Key key, this.labelId, this.id, this.isLike})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainBloc bloc = BlocProvider.of<MainBloc>(context);

    return new InkWell(
      onTap: () {},
      child: new Icon(
        Icons.favorite,
        color: (isLike == true && Util.isLogin())
            ? Colors.redAccent
            : AppColors.gray_99,
      ),
    );
  }
}

class StatusViews extends StatelessWidget {
  final int status;
  final GestureTapCallback onTap;

  const StatusViews(this.status, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case LoadStatus.fail:
        return new Container(
          width: double.infinity,
          child: new Material(
            color: Colors.white,
            child: new InkWell(
              onTap: () {
                onTap();
              },
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    Utils.getImgPath('ic_network_error'),
                    package: BaseConstant.packageBase,
                    width: 100,
                    height: 100,
                  ),
                  new Text(
                    "网络出问题了，请您检查网络设置",
                    style: TextStyles.listContent,
                  ),
                  new Text(
                    "点击屏幕，重新加载",
                    style: TextStyles.listContent,
                  )
                ],
              ),
            ),
          ),
        );
    }
    return null;
  }
}
