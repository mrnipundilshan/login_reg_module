import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/password_field.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _mobileFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _mobileFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.register(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      mobileNumber: _mobileController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      _showSnackBar(authProvider.successMessage!, isError: false);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } else {
      _showSnackBar(authProvider.errorMessage!);
    }
  }

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
              size: AppConstants.iconSizeSmall,
            ),
            const SizedBox(width: AppConstants.spacingSmall),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError
            ? AppConstants.errorColor
            : AppConstants.accentColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        ),
        margin: const EdgeInsets.all(AppConstants.paddingMedium),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppConstants.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppConstants.maxFormWidth,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: AppConstants.spacingXLarge),
                    _buildNameField(),
                    const SizedBox(height: AppConstants.paddingMedium),
                    _buildEmailField(),
                    const SizedBox(height: AppConstants.paddingMedium),
                    _buildMobileField(),
                    const SizedBox(height: AppConstants.paddingMedium),
                    _buildPasswordField(),
                    const SizedBox(height: AppConstants.paddingMedium),
                    _buildConfirmPasswordField(),
                    const SizedBox(height: AppConstants.paddingLarge),
                    _buildRegisterButton(),
                    const SizedBox(height: AppConstants.paddingLarge),
                    _buildLoginLink(),
                    const SizedBox(height: AppConstants.paddingMedium),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: AppConstants.avatarSize,
          height: AppConstants.avatarSize,
          decoration: BoxDecoration(
            color: AppConstants.accentColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person_add_alt_1_rounded,
            size: AppConstants.iconSizeLarge,
            color: AppConstants.accentColor,
          ),
        ),
        const SizedBox(height: AppConstants.paddingMedium),
        const Text(AppStrings.registerTitle, style: AppConstants.headingStyle),
        const SizedBox(height: AppConstants.spacingSmall),
        const Text(
          AppStrings.registerSubtitle,
          style: AppConstants.subheadingStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return CustomTextField(
      controller: _nameController,
      label: AppStrings.fullName,
      hint: AppStrings.fullNameHint,
      prefixIcon: Icons.person_outline,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _emailFocusNode.requestFocus(),
      validator: Validators.fullName,
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      label: AppStrings.email,
      hint: AppStrings.emailHint,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onFieldSubmitted: (_) => _mobileFocusNode.requestFocus(),
      validator: Validators.email,
    );
  }

  Widget _buildMobileField() {
    return CustomTextField(
      controller: _mobileController,
      label: AppStrings.mobileNumber,
      hint: AppStrings.mobileHint,
      prefixIcon: Icons.phone_outlined,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      focusNode: _mobileFocusNode,
      onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      validator: Validators.mobileNumber,
    );
  }

  Widget _buildPasswordField() {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return PasswordField(
          controller: _passwordController,
          label: AppStrings.password,
          obscureText: auth.obscurePassword,
          onToggleVisibility: auth.togglePasswordVisibility,
          focusNode: _passwordFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => _confirmPasswordFocusNode.requestFocus(),
          validator: Validators.password,
        );
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return PasswordField(
          controller: _confirmPasswordController,
          label: AppStrings.confirmPassword,
          obscureText: auth.obscureConfirmPassword,
          onToggleVisibility: auth.toggleConfirmPasswordVisibility,
          focusNode: _confirmPasswordFocusNode,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _handleRegistration(),
          validator: (value) =>
              Validators.confirmPassword(value, _passwordController.text),
        );
      },
    );
  }

  Widget _buildRegisterButton() {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return CustomButton(
          text: AppStrings.registerTitle,
          isLoading: auth.isLoading,
          onPressed: _handleRegistration,
          backgroundColor: AppConstants.accentColor,
          icon: Icons.person_add_alt_1_rounded,
        );
      },
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          AppStrings.alreadyHaveAccount,
          style: TextStyle(color: AppConstants.textSecondary, fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            context.read<AuthProvider>().reset();
            Navigator.of(context).pop();
          },
          child: const Text(
            AppStrings.signIn,
            style: AppConstants.linkTextStyle,
          ),
        ),
      ],
    );
  }
}
