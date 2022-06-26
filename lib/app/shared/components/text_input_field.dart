import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextInputFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final Icon icon;
  final String text;
  final Function validate;
  final String val;
  final bool obscureText;
  final MaskTextInputFormatter mask;
  final type;
  final size;
  final bool enabled;
  final String readeOnly;
  final Function onEditingComplete;

  TextInputFieldComponent(
    this.controller,
    this.icon,
    this.text,
    this.validate,
    this.type, {
    this.size: 1,
    this.obscureText: false,
    this.mask,
    this.val,
    this.enabled: true,
    this.readeOnly: '',
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    controller.text = this.val;
    return Container(
      child: TextFormField(
        enabled: this.enabled,
        controller: controller,
        obscureText: this.obscureText,
        keyboardType: this.type,
        textInputAction: TextInputAction.done,
        validator: this.validate,
        onEditingComplete: this.onEditingComplete,
        decoration: InputDecoration(
          labelText: text,
          icon: icon,
          hintText: this.readeOnly,
        ),
        inputFormatters: (mask != null ? [mask] : []),
      ),
      width: MediaQuery.of(context).size.width * size,
    );
  }
}
