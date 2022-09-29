import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_icons.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/theme/theme.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:flutter/material.dart';

enum DUInsideKind {
  prefixIcon,
  suffixIcon,
  suffixClear,
  prefixButton,
  suffixButton,
  prefixText,
  suffixText,
}

typedef BoolCallback = bool? Function();

class DUInsideButton extends StatefulWidget {
  //* 아이콘 버튼
  const DUInsideButton.prefixIcon({
    super.key,
    this.color,
    required this.icon,
    this.iconSize,
    required this.onPressed,
    this.focusNode,
  })  : label = null,
        text = null,
        onCleared = null,
        onTapDown = null,
        controller = null,
        kind = DUInsideKind.prefixIcon;

  const DUInsideButton.suffixIcon({
    super.key,
    this.color,
    required this.icon,
    this.iconSize,
    required this.onPressed,
    this.focusNode,
  })  : label = null,
        text = null,
        onCleared = null,
        onTapDown = null,
        controller = null,
        kind = DUInsideKind.suffixIcon;

  //* 텍스트 클리어 버튼
  // controller를 넣어주면 자동삭제, 아닐시 onCleared함수 구현
  const DUInsideButton.suffixClear({
    super.key,
    this.color,
    this.icon,
    this.iconSize,
    this.label,
    this.text,
    this.onCleared,
    this.onPressed,
    this.onTapDown,
    this.controller,
    this.focusNode,
  }) : kind = DUInsideKind.suffixClear;

  //* 아웃라인 버튼
  const DUInsideButton.prefixButton({
    super.key,
    this.color,
    this.label,
    this.onPressed,
    this.focusNode,
  })  : icon = null,
        iconSize = null,
        text = null,
        onCleared = null,
        onTapDown = null,
        controller = null,
        kind = DUInsideKind.prefixButton;

  const DUInsideButton.suffixButton({
    super.key,
    this.color,
    this.label,
    this.onPressed,
    this.focusNode,
  })  : icon = null,
        iconSize = null,
        text = null,
        onCleared = null,
        onTapDown = null,
        controller = null,
        kind = DUInsideKind.suffixButton;

  //* 텍스트
  const DUInsideButton.prefixText({
    super.key,
    this.color = DUColors.grey0,
    this.text,
    this.onPressed,
    this.onTapDown,
    this.focusNode,
  })  : icon = null,
        iconSize = null,
        label = null,
        onCleared = null,
        controller = null,
        kind = DUInsideKind.prefixText;

  const DUInsideButton.suffixText({
    super.key,
    this.color = DUColors.grey0,
    this.text,
    this.onPressed,
    this.onTapDown,
    this.focusNode,
  })  : icon = null,
        iconSize = null,
        label = null,
        onCleared = null,
        controller = null,
        kind = DUInsideKind.suffixText;

  final DUInsideKind kind;

  final Color? color;
  final dynamic icon;
  final double? iconSize;
  final dynamic label;
  final dynamic text;
  final BoolCallback? onCleared;
  final VoidCallback? onPressed;
  final void Function(TapDownDetails)? onTapDown;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  State<StatefulWidget> createState() => _DUInsideButtonState();
}

class _DUInsideButtonState extends State<DUInsideButton> {
  @override
  void initState() {
    super.initState();

    if (widget.kind == DUInsideKind.suffixClear && widget.focusNode != null) {
      widget.focusNode?.addListener(() {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.kind) {
      //* 아이콘 버튼
      case DUInsideKind.prefixIcon:
      case DUInsideKind.suffixIcon:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.kind == DUInsideKind.prefixIcon) const SizedBox(width: 8),
            // 아이콘
            GestureDetector(
              onTap: widget.onPressed == null
                  ? null
                  : () {
                      widget.focusNode?.requestFocus();
                      widget.onPressed!();
                    },
              child: widget.icon is Widget
                  ? widget.icon
                  : Icon(widget.icon, color: DUColors.grey1, size: widget.iconSize ?? 24),
            ),
            const SizedBox(width: 8),
          ],
        );

      //* 아웃라인 버튼
      case DUInsideKind.prefixButton:
      case DUInsideKind.suffixButton:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.kind == DUInsideKind.prefixButton) const SizedBox(width: 8),
            // 버튼
            OutlinedButton(
              child: widget.label is Widget
                  ? widget.label
                  : Text(
                      widget.label as String,
                    ),
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(DUTextStyle.size12),
                minimumSize: MaterialStateProperty.all(Size.zero),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                shape: MaterialStateProperty.all(const StadiumBorder()),
                foregroundColor: materialStateColor(DUColors.grey0, DUColors.grey3),
                side: materialStateBorder(DUColors.grey3, DUColors.grey4),
              ),
              onPressed: widget.onPressed == null
                  ? null
                  : () {
                      widget.focusNode?.requestFocus();
                      widget.onPressed!();
                    },
            ),
            const SizedBox(width: 8),
          ],
        );

      //* 텍스트
      case DUInsideKind.prefixText:
      case DUInsideKind.suffixText:
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: widget.kind == DUInsideKind.prefixText ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            if (widget.kind == DUInsideKind.prefixText) const SizedBox(width: 8),
            // 텍스트
            GestureDetector(
              onTap: widget.onPressed == null
                  ? null
                  : () {
                      widget.focusNode?.requestFocus();
                      widget.onPressed!();
                    },
              onTapDown: widget.onTapDown,
              child: widget.text is Widget
                  ? widget.text
                  : Text(
                      widget.text as String,
                      style: DUTextStyle.size14.h1_5.copyWith(color: widget.color),
                    ),
            ),
            const SizedBox(width: 8),
          ],
        );

      //* 텍스트 클리어 버튼
      case DUInsideKind.suffixClear:
        return widget.controller == null
            ? _clearWidget
            : ValueListenableBuilder(
                valueListenable: widget.controller!,
                builder: (BuildContext context, dynamic value, Widget? child) {
                  return _clearWidget;
                },
              );
    }
  }

  Widget get _clearWidget {
    if (_editableText == false && widget.icon == null && widget.label == null && widget.text == null) {
      return const SizedBox.shrink();
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.text != null) ...[
            // 텍스트
            GestureDetector(
              onTap: widget.onPressed == null
                  ? null
                  : () {
                      widget.focusNode?.requestFocus();
                      widget.onPressed!();
                    },
              onTapDown: widget.onTapDown,
              child: widget.text is Widget
                  ? widget.text
                  : Text(
                      widget.text as String,
                      style: DUTextStyle.size14.h1_5.copyWith(color: widget.color),
                    ),
            ),
            if (_editableText)
              const SizedBox(
                height: 16,
                child: VerticalDivider(
                  width: 8,
                  thickness: 1,
                  color: DUColors.grey4,
                ),
              ),
          ],
          // 클리어 버튼
          if (_editableText)
            GestureDetector(
              onTap: () {
                widget.focusNode?.requestFocus();
                //* onCleared에서 true를 리턴해야 텍스트를 지웁니다.
                if (widget.onCleared == null || widget.onCleared!() != false) {
                  widget.controller?.clear();
                }
              },
              child: Icon(DUIcons.del, color: DUColors.grey1, size: widget.iconSize ?? 24),
            ),
          // IconButton(
          //   key: key,
          //   padding: EdgeInsets.zero,
          //   constraints: BoxConstraints(),
          //   icon:
          //   iconSize: iconSize?.ratio ?? 24.ratio,
          //   splashRadius: 28,
          //   splashColor: Colors.transparent,
          //   highlightColor: Colors.transparent,
          //   onPressed: () {
          //     focusNode?.requestFocus();
          //     //* onCleared에서 true를 리턴해야 텍스트를 지웁니다.
          //     if (onCleared == null || onCleared!() != false) {
          //       controller?.clear();
          //     }
          //   },
          // ),
          if (widget.icon != null) ...[
            if (_editableText)
              const SizedBox(
                height: 16,
                child: VerticalDivider(
                  width: 4,
                  thickness: 1,
                  color: DUColors.grey4,
                ),
              ),
            GestureDetector(
              onTap: widget.onPressed == null
                  ? null
                  : () {
                      widget.focusNode?.requestFocus();
                      widget.onPressed!();
                    },
              child: widget.icon is Widget
                  ? widget.icon
                  : Icon(widget.icon, color: DUColors.grey1, size: widget.iconSize ?? 24),
            ),
          ],
          if (widget.label != null) ...[
            if (_editableText) ...[
              const SizedBox(
                height: 16,
                child: VerticalDivider(
                  width: 8,
                  thickness: 1,
                  color: DUColors.grey4,
                ),
              ),
              const SizedBox(width: 2),
            ],
            // 버튼
            OutlinedButton(
              child: widget.label is Widget ? widget.label : Text(widget.label as String),
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(DUTextStyle.size12),
                minimumSize: MaterialStateProperty.all(Size.zero),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8, vertical: 6)),
                shape: MaterialStateProperty.all(const StadiumBorder()),
                foregroundColor: materialStateColor(DUColors.grey0, DUColors.grey3),
                side: materialStateBorder(DUColors.grey3, DUColors.grey4),
              ),
              onPressed: widget.onPressed == null
                  ? null
                  : () {
                      widget.focusNode?.requestFocus();
                      widget.onPressed!();
                    },
            ),
          ],
          const SizedBox(width: 8),
        ],
      );
    }
  }

  bool get _editableText => widget.controller?.text.isNotEmpty == true && widget.focusNode?.hasFocus == true;
}
