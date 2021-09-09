import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({required this.controller, this.labelText = "", this.maxLines, this.padding, this.onChanged});
  final TextEditingController controller;
  final String labelText;
  final int? maxLines;
  final EdgeInsets? padding;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(left: 8.0, top: 8, right: 4, bottom: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(border: OutlineInputBorder(), labelText: "$labelText"),
      ),
    );
  }
}
