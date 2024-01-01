import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController editingController;
  final String hintText;
  const CustomTextField(
      {super.key, required this.editingController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Enter your $hintText";
        }
        return null;
      },
      controller: editingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
      ),
    );
  }
}
