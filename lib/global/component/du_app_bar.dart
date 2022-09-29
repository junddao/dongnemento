import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}

///DU전용 앱바(높이:56)
class DUAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  DUAppBar({
    super.key,
    this.title = '',
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shadowColor = Colors.transparent,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    this.leadingWidth = 56.0,
    this.backwardsCompatibility,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
  }) : preferredSize = _PreferredAppBarSize(toolbarHeight ?? 56, bottom?.preferredSize.height);

  final dynamic title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Brightness? brightness;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final TextTheme? textTheme;
  final bool primary;
  final bool? centerTitle;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  final double? toolbarHeight;
  final double leadingWidth;
  final bool? backwardsCompatibility;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
      title: _getTitleWidget(title),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: _addRightSizedBox8(actions),
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      centerTitle: centerTitle ?? false,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing ?? (leading == null ? 16 : 0),
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      toolbarHeight: toolbarHeight ?? preferredSize.height,
      leadingWidth: leadingWidth,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle: titleTextStyle,
      systemOverlayStyle: systemOverlayStyle,
    );
  }

  Widget _getTitleWidget(dynamic title) {
    if (title is String) {
      return Text(title);
    } else {
      return title;
    }
  }

  List<Widget>? _addRightSizedBox8(List<Widget>? actions) {
    if (actions != null) {
      return [...actions, const SizedBox(width: 8)];
    } else {
      return null;
    }
  }
}
