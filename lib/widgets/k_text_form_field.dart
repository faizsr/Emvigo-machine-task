import 'package:emvigo_machine_task/constants/app_colors.dart';
import 'package:flutter/material.dart';

class KTextFormField extends StatelessWidget {
  const KTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
  });

  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
      ),
    );
  }
}
