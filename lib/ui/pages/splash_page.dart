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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> _guideList = [
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
          ObjectUtil.isNotEmpty(_guideList)) {
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

  void _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(new Stack(
          children: <Widget>[
            new Image.asset(
              _guideList[i],
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                margin: EdgeInsets.only(bottom: 160.0),
                child: new InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: new Text('11111111111')));
                  },
                  child: new CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.indigoAccent,
                    child: new Padding(
                      padding: EdgeInsets.all(2.0),
                      child: new Text(
                        '立即体验',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
      } else {
        _bannerList.add(new Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }

  void _initSplash() {
    if (_splashModel == null) {
      _goMain();
    } else {
      _doCountDown();
    }
  }

  void _goMain() {}

  void _doCountDown() {
    setState(() {
      _status = 1;
    });
    _timerUtil = new TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  void _loadSplashData() {
    _splashModel = SpHelper.getObject<SplashModel>(Constant.key_splash_model);
    _splashModel = null;
    LogUtil.e(_splashModel);
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

  Widget _buildAdWidget() {
    if (_splashModel == null)
      return new Container(
        height: 0.0,
      );
    return new Offstage(
      offstage: !(_status == 1),
      child: new InkWell(
        onTap: () {},
        child: new Container(
          alignment: Alignment.center,
          child: new CachedNetworkImage(
            imageUrl: _splashModel.imgUrl,
            placeholder: (context, url) => _buildSplashBg(),
            errorWidget: (context, url, error) => _buildSplashBg(),
          ),
        ),
      ),
    );
  }

  /**
   * Stack  一种层叠布局
   */
  @override
  Widget build(BuildContext context) {
    LogUtil.e(_status);
    LogUtil.e(_bannerList);
    return new Scaffold(
      key: _scaffoldKey,
      body: new Material(
        child: new Stack(
          children: <Widget>[
            new Offstage(
              offstage: !(_status == 0),
              child: _buildSplashBg(),
            ),
            new Offstage(
              offstage: !(_status == 2),
              child: ObjectUtil.isEmpty(_bannerList)
                  ? new Container()
                  : new Swiper(
                      autoStart: false,
                      circular: false,
                      indicator: CircleSwiperIndicator(
                          radius: 4.0,
                          padding: EdgeInsets.only(bottom: 30.0),
                          itemColor: Colors.black26),
                      children: _bannerList,
                    ),
            ),
            _buildAdWidget(),
            new Offstage(
              offstage: !(_status == 1),
              child: new Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {
                    _goMain();
                  },
                  child: new Container(
                      padding: EdgeInsets.all(12.0),
                      child: new Text(
                        IntlUtil.getString(context, Ids.jump_count,
                            params: ['$_count']),
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      decoration: new BoxDecoration(
                          color: Color(0x66000000),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          border: new Border.all(
                              width: 0.33, color: AppColors.divider))),
                ),
              ),
            )
          ],
        ),
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
