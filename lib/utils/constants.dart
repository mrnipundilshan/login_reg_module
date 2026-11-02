import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const Color primaryColor = Color(0xFF4A90D9);
  static const Color primaryDark = Color(0xFF2C6BB0);
  static const Color accentColor = Color(0xFF50C878);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color warningColor = Colors.orange;
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color backgroundLight = Color(0xFFF5F7FA);
  static const Color cardBackground = Colors.white;
  static const Color dividerColor = Color(0xFFE0E0E0);

  static const double spacingTiny = 2.0;
  static const double spacingExtraSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  static const double spacingXXLarge = 40.0;

  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  static const double buttonHeight = 54.0;
  static const double maxFormWidth = 450.0;
  static const double avatarSize = 80.0;
  static const double avatarSizeLarge = 80.0;

  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 22.0;
  static const double iconSizeLarge = 40.0;
  static const double iconSizeXLarge = 60.0;

  static const double loadingIndicatorSize = 24.0;
  static const double checkboxSize = 24.0;
  static const double progressStrokeWidth = 2.5;

  static const double borderWidth = 1.5;
  static const double borderWidthThick = 2.0;

  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 10.0;
  static const double borderRadius = 12.0;
  static const double borderRadiusCard = 16.0;
  static const double borderRadiusLarge = 20.0;

  static const TextStyle headingStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 16,
    color: textSecondary,
    height: 1.5,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle linkTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  static const int mockApiDelay = 1500;

  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');

  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-d\d@$!%*?&]{8,}$',
  );
}

class AppStrings {
  AppStrings._();

  static const String appTitle = 'Login & Registration';

  static const String loginTitle = 'Welcome Back';
  static const String loginSubtitle = 'Sign in to continue to your account';
  static const String username = 'Username';
  static const String usernameHint = 'Enter your username';
  static const String password = 'Password';
  static const String rememberMe = 'Remember me';
  static const String forgotPassword = 'Forgot Password?';
  static const String signIn = 'Sign In';
  static const String orDivider = 'OR';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String signUp = 'Sign Up';

  static const String registerTitle = 'Create Account';
  static const String registerSubtitle =
      'Fill in the details below to get started';
  static const String fullName = 'Full Name';
  static const String fullNameHint = 'Enter your full name';
  static const String email = 'Email Address';
  static const String emailHint = 'Enter your email address';
  static const String mobileNumber = 'Mobile Number';
  static const String mobileHint = 'Enter your 10-digit mobile number';
  static const String confirmPassword = 'Confirm Password';
  static const String alreadyHaveAccount = 'Already have an account? ';

  static const String forgotPasswordTitle = 'Forgot Password?';
  static const String forgotPasswordSubtitle =
      "Enter your email address and we'll send you\na link to reset your password.";
  static const String forgotPasswordEmailHint = 'Enter your registered email';
  static const String sendResetLink = 'Send Reset Link';
  static const String backToSignIn = 'Back to Sign In';

  static const String home = 'Home';
  static const String logout = 'Logout';
  static const String welcome = 'Welcome';
  static const String loginSuccessSubtitle = 'You have successfully logged in.';
  static const String accountDetails = 'Account Details';
  static const String name = 'Name';
  static const String phone = 'Phone';
  static const String notAvailable = 'N/A';
  static const String signOut = 'Sign Out';
  static const String signOutConfirmation =
      'Are you sure you want to sign out?';
  static const String cancel = 'Cancel';

  static const String showPassword = 'Show password';
  static const String hidePassword = 'Hide password';

  static const String requiredSuffix = 'is required';
  static const String nameMinLength = 'Name must be at least 2 characters';
  static const String nameLettersOnly =
      'Name can only contain letters and spaces';
  static const String invalidEmail = 'Please enter a valid email address';
  static const String invalidMobile =
      'Please enter a valid 10-digit mobile number';
  static const String invalidEmailOrMobile =
      'Please enter a valid email or 10-digit mobile number';
  static const String passwordMinLength =
      'Password must be at least 8 characters';
  static const String passwordUppercase =
      'Password must contain at least one uppercase letter';
  static const String passwordLowercase =
      'Password must contain at least one lowercase letter';
  static const String passwordNumber =
      'Password must contain at least one number';
  static const String passwordSpecial =
      r'Password must contain at least one special character (@$!%*?&)';
  static const String passwordMismatch = 'Passwords do not match';
}
