import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

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
    );
  }
}
