import 'constants.dart';

class Validators {
  Validators._();

  static String? required(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName ${AppStrings.requiredSuffix}';
    }
    return null;
  }

  static String? fullName(String? value) {
    final requiredCheck = required(value, AppStrings.fullName);
    if (requiredCheck != null) return requiredCheck;

    if (value!.trim().length < 2) {
      return AppStrings.nameMinLength;
    }

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
      return AppStrings.nameLettersOnly;
    }

    return null;
  }

  static String? email(String? value) {
    final requiredCheck = required(value, AppStrings.email);
    if (requiredCheck != null) return requiredCheck;

    if (!AppConstants.emailRegex.hasMatch(value!.trim())) {
      return AppStrings.invalidEmail;
    }

    return null;
  }

  static String? mobileNumber(String? value) {
    final requiredCheck = required(value, AppStrings.mobileNumber);
    if (requiredCheck != null) return requiredCheck;

    if (!AppConstants.phoneRegex.hasMatch(value!.trim())) {
      return AppStrings.invalidMobile;
    }

    return null;
  }

  static String? emailOrMobile(String? value) {
    final requiredCheck = required(value, AppStrings.email);
    if (requiredCheck != null) return requiredCheck;

    final trimmed = value!.trim();
    final isEmail = AppConstants.emailRegex.hasMatch(trimmed);
    final isPhone = AppConstants.phoneRegex.hasMatch(trimmed);

    if (!isEmail && !isPhone) {
      return AppStrings.invalidEmailOrMobile;
    }

    return null;
  }

  static String? password(String? value) {
    final requiredCheck = required(value, AppStrings.password);
    if (requiredCheck != null) return requiredCheck;

    if (value!.length < 8) {
      return AppStrings.passwordMinLength;
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return AppStrings.passwordUppercase;
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return AppStrings.passwordLowercase;
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return AppStrings.passwordNumber;
    }

    if (!value.contains(RegExp(r'[@$!%*?&]'))) {
      return AppStrings.passwordSpecial;
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    final requiredCheck = required(value, AppStrings.confirmPassword);
    if (requiredCheck != null) return requiredCheck;

    if (value != password) {
      return AppStrings.passwordMismatch;
    }

    return null;
  }
}
