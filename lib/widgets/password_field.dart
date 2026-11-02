import 'package:flutter/material.dart';

import '../utils/constants.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;

  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.obscureText,
    required this.onToggleVisibility,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      style: const TextStyle(fontSize: 16, color: AppConstants.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: AppConstants.textSecondary,
          size: AppConstants.iconSizeMedium,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: AppConstants.textSecondary,
            size: AppConstants.iconSizeMedium,
          ),
          onPressed: onToggleVisibility,
          tooltip: obscureText
              ? AppStrings.showPassword
              : AppStrings.hidePassword,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingMedium,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(color: AppConstants.dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(color: AppConstants.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(
            color: AppConstants.primaryColor,
            width: AppConstants.borderWidthThick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(color: AppConstants.errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(
            color: AppConstants.errorColor,
            width: AppConstants.borderWidthThick,
          ),
        ),
        labelStyle: const TextStyle(color: AppConstants.textSecondary),
        errorStyle: const TextStyle(fontSize: 12),
      ),
    );
  }
}
