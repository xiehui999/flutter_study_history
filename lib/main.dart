import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_study_history/common/component_index.dart';
import 'package:flutter_study_history/ui/pages/page_index.dart';

void main() => runApp(BlocProvider<ApplicationBloc>(
    child: BlocProvider(child: MyApp(), bloc: MainBloc()),
    bloc: ApplicationBloc()));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  Locale _locale;
  Color _themeColor = AppColors.app_main;

  @override
  void initState() {
    super.initState();
//    setLocalizedSimpleValues(localizedSimpleValues);//配置简单多语言资源
    setLocalizedValues(localizedValues); //配置多语言资源
    _initAsync();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: {BaseConstant.routeMain: (context) => MainPage()},
      home: new SplashPage(),
      theme: ThemeData.light().copyWith(
        primaryColor: _themeColor,
        accentColor: _themeColor,
        indicatorColor: Colors.white,
      ),
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate,
      ],
      supportedLocales: CustomLocalizations.supportedLocales,
    );
  }

  void _initAsync() async {
    await SpUtil.getInstance();
    if (!mounted) return;
    _init();
    _loadLocale();
  }

  void _init() {
    Options options = DioUtil.getDefOptions();
    options.baseUrl = Constant.server_address;
    String cookie = SpUtil.getString(BaseConstant.keyAppToken);
    LogUtil.e("111111111111111");
    if (ObjectUtil.isNotEmpty(cookie)) {
      Map<String, dynamic> _headers = new Map();
      _headers["Cookie"] = cookie;
      options.headers = _headers;
    }
    HttpConfig httpConfig = new HttpConfig(options: options);
    DioUtil.openDebug();
    DioUtil().setConfig(httpConfig);
  }

  void _loadLocale() {
    setState(() {
      LanguageModel model =
          SpHelper.getObject<LanguageModel>(Constant.keyLanguage);
      if (model != null) {
        _locale = new Locale(model.languageCode, model.countryCode);
      } else {
        _locale = null;
      }
      String _colorKey = SpHelper.getThemeColor();
      if (themeColorMap[_colorKey] != null) {
        _themeColor = themeColorMap[_colorKey];
      }
    });
  }
}
