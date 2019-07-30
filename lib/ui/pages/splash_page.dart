import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  TimerUtil _timerUtil;

  List<String> _guidList = [
    Utils.getImgPath('guide1'),
    Utils.getImgPath('guide2'),
    Utils.getImgPath('guide3'),
    Utils.getImgPath('guide4'),
  ];
  List<Widget> _bannerList = new List();
  int _status = 0;
  int _count = 3;
  SplashModel _splashModel;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  void _initAsync() async {
    await SpUtil.getInstance();
    _loadSplashData();
    Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
      if (SpUtil.getBool(Constant.key_guide, defValue: true) &&
          ObjectUtil.isEmpty(_guidList)) {
        SpUtil.putBool(Constant.key_guide, false);
        _initBanner();
      } else {
        _initSplash();
      }
    });
  }

  void _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }

  void _initBannerData() {}

  void _initSplash() {}

  void _loadSplashData() {
    _splashModel = SpHelper.getObject<SplashModel>(Constant.key_splash_model);
    if (_splashModel != null) {
      setState(() {});
    }
    HttpUtils httpUtils = new HttpUtils();
    httpUtils.getSplash().then((model) {
      if (!ObjectUtil.isEmpty(model.imgUrl)) {
        if (_splashModel == null || (_splashModel.imgUrl != model.imgUrl)) {
          SpHelper.putObject(Constant.key_splash_model, model);

          setState(() {
            _splashModel = model;
          });
        } else {
          SpHelper.putObject(Constant.key_splash_model, null);
        }
      }
    });
  }

  /**
   * Stack  一种层叠布局
   */
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: !(_status == 0),
            child: _buildSplashBg(),
          )
        ],
      ),
    );
  }

  /**
   * 设置double.infinity可以强制撑满容器
   */
  Widget _buildSplashBg() {
    return new Image.asset(
      Utils.getImgPath('splash_bg'),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fitHeight,
    );
  }
}
