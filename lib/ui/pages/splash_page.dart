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
  }

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

  @override
  Widget build(BuildContext context) {
    return Text("222");
  }
}
