import 'package:base_project/global/style/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

// ignore: must_be_immutable
class DUTextFormField extends StatefulWidget {
  final Widget? child;
  final FocusNode? focusNode;
  final String? title;
  final String? hintText;
  final String? warningMessage;
  final FormFieldValidator<String>? validator;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool autocorrect;
  final bool autofocus;
  final bool showSecure;
  final bool showClear;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  bool isSecure = false;
  DUTextFormField({
    Key? key,
    this.focusNode,
    this.child,
    this.title,
    this.hintText,
    this.autocorrect = false,
    this.autofocus = false,
    this.warningMessage,
    this.validator,
    this.icon,
    this.isSecure = false,
    this.showSecure = false,
    this.showClear = false,
    this.onChanged,
    this.controller,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  DUTextFormFieldState createState() => DUTextFormFieldState();
}

class DUTextFormFieldState extends State<DUTextFormField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      autocorrect: widget.autocorrect,
      autofocus: widget.autofocus,
      textCapitalization: TextCapitalization.none,
      obscureText: widget.isSecure,
      onChanged: (text) {
        setState(() {});
        if (widget.onChanged != null) {
          widget.onChanged!(text);
        }
      },
      validator: widget.warningMessage == null || widget.validator != null
          ? widget.validator
          : _validateText,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
        isDense: true,
        labelText: widget.title,
        hintText: widget.hintText,
        fillColor: Colors.blue,
        icon: widget.icon == null
            ? null
            : Icon(widget.icon, color: kPrimaryColor),
        suffixIcon: suffixIcon(),
      ),
    );
  }

  Widget? suffixIcon() {
    if (widget.showSecure) {
      return IconButton(
        icon: widget.isSecure
            ? const Icon(Icons.visibility, color: kPrimaryColor)
            : const Icon(Icons.visibility_off, color: kPrimaryColor),
        onPressed: () {
          setState(() {
            widget.isSecure = !widget.isSecure;
          });
        },
      );
    }
    if (widget.showClear) {
      return widget.controller!.text.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear_rounded, size: 15),
              onPressed: () {
                setState(() {
                  widget.controller!.clear();
                });
              })
          : null;
    }
    return null;
  }

  String? _validateText(String? text) {
    if (text == null || text.isEmpty || text.trim().isEmpty) {
      return widget.warningMessage;
    } else {
      return null;
    }
  }
}
