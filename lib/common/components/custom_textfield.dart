import 'package:flutter/material.dart';

import 'custom_suffix_icon.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController editingController;
  final String hintText;
  final int maxLines;
  final String? iconPath;
  final TextInputType? textInputType;
  final bool isObscureText;
  final String? Function(String?)? validateField;

  const CustomTextField({
    super.key,
    required this.editingController,
    required this.hintText,
    this.maxLines = 1,
    this.iconPath,
    this.textInputType,
    this.isObscureText = false,
    this.validateField,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validateField == null
          ? (val) {
              if (val == null || val.isEmpty) {
                return "$hintText field is required";
              }
              return null;
            }
          : ((val) => validateField!(val)),
      controller: editingController,
      keyboardType: textInputType,
      obscureText: isObscureText,
      decoration: InputDecoration(
        labelText: hintText,
        //floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        suffixIcon:
            iconPath != null ? CustomSuffixIcon(iconPath: iconPath) : null,
      ),
      maxLines: maxLines,
    );
  }
}
