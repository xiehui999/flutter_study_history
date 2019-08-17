import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

class TreeItem extends StatelessWidget {
  final TreeModel model;

  const TreeItem(this.model, {Key key}) : super(key: key);

  /**
   * Chip 类似标签的组件
   *avatar  左侧图标、
   * label：显示文字
   * deleteIcon：右侧删除图标,需要写onDeleted方法，否则不显示
   * onDeleted：删除回调，使用时会默认有删除图标，可通过deleteIcon更改
   * deleteButtonTooltipMessageL点击删除图标弹出的提示信息，
   * elevation:阴影深度
   * shadowColor：阴影颜色
   */
  @override
  Widget build(BuildContext context) {
    final List<Widget> chips = model.children.map((TreeModel _model) {
      return Chip(
        elevation: 3,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: Utils.getChipBgColor(_model.name),
          label: new Text(
            _model.name,
            style: new TextStyle(fontSize: 14),
          ));
    }).toList();

    return new InkWell(
      onTap: () {},
      child: new _ChipsTile(
        label: model.name,
        children: chips,
      ),
    );
  }
}

class _ChipsTile extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const _ChipsTile({Key key, this.label, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> cardChildren = <Widget>[
      new Text(
        label,
        style: TextStyles.listTitle,
      ),
      Gaps.vGap10
    ];
    cardChildren.add(Wrap(
        children: children.map((Widget chip) {
      return Padding(
        padding: EdgeInsets.all(3),
        child: chip,
      );
    }).toList()));
    return new Container(
      padding: EdgeInsets.all(16),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: cardChildren,
      ),
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: new BorderSide(width: 0.33, color: AppColors.divider))),
    );
  }
}
