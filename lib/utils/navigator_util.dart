import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_study_history/ui/pages/tab_page.dart';

class NavigatorUtil {
  static void pushWeb(BuildContext context,
      {String title, String titleId, String url, bool isHome: false}) {
    if (context == null || ObjectUtil.isEmpty(url)) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title ?? titleId);
    } else {
      Navigator.push(
          context,
          new CupertinoPageRoute(
              builder: (ctx) => new WebScaffold(
                    title: title,
                    titleId: titleId,
                    url: url,
                  )));
    }
  }

  static void pushTabPage(BuildContext context,
      {String labelId, String title, String titleId, TreeModel treeModel}) {
    if (context == null) return;
    Navigator.push(context, new CupertinoPageRoute(builder: (ctx) {
      return new BlocProvider<TabBloc>(
          child: new TabPage(
            labelId: labelId,
            title: title,
            titleId: titleId,
            treeModel: treeModel,
          ),
          bloc: new TabBloc());
    }));
  }

  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch ${url}';
    }
  }
}
