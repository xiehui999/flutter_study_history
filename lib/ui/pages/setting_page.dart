import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';
import 'package:flutter_study_history/ui/pages/page_index.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    LanguageModel languageModel =
        SpHelper.getObject<LanguageModel>(Constant.keyLanguage);

    return Scaffold(
      appBar: AppBar(
        title: Text(IntlUtil.getString(context, Ids.titleSetting)),
      ),
      body: ListView(
        children: <Widget>[
          new ExpansionTile(
            title: new Row(
              children: <Widget>[
                Icon(
                  Icons.color_lens,
                  color: AppColors.gray_66,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(IntlUtil.getString(context, Ids.titleTheme)),
                ),
              ],
            ),
            children: <Widget>[
              new Wrap(
                children: themeColorMap.keys.map((String key) {
                  Color color = themeColorMap[key];
                  return new InkWell(
                    onTap: () {
                      SpUtil.putString(Constant.key_theme_color, key);
                      bloc.sendAppEvent(Constant.type_sys_update);
                    },
                    child: new Container(
                      margin: EdgeInsets.all(5),
                      width: 36,
                      height: 36,
                      color: color,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
          new ListTile(
            title: new Row(
              children: <Widget>[
                Icon(
                  Icons.language,
                  color: AppColors.gray_66,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(IntlUtil.getString(context, Ids.titleLanguage)),
                )
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    languageModel == null
                        ? IntlUtil.getString(context, Ids.languageAuto)
                        : IntlUtil.getString(context, languageModel.titleId,
                            languageCode: 'zh', countryCode: 'CH'),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.gray_99,
                    )),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
            onTap: () {
              NavigatorUtil.pushPage(context, LanguagePage(),pageName: Ids.titleLanguage);
            },
          )
        ],
      ),
    );
  }
}
