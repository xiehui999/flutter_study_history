import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

bool isHomeInit = true;

class HomePage extends StatelessWidget {
  final String labelId;

  const HomePage({Key key, this.labelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = new RefreshController();
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    return null;
  }
}
