import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigatorUtil {
  static void pushWeb(BuildContext context,
      {String title, String titleId, String url, bool isHome: false}) {
    if (context == null || ObjectUtil.isEmpty(url)) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title ?? titleId);
    }
  }

  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch ${url}';
    }
  }
}
