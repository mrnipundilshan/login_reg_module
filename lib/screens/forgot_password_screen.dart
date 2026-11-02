import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.forgotPassword(
      email: _emailController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      _showSnackBar(authProvider.successMessage!, isError: false);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) Navigator.of(context).pop();
      });
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
                    const SizedBox(height: AppConstants.spacingXXLarge),
                    _buildEmailField(),
                    const SizedBox(height: AppConstants.spacingLarge),
                    _buildSubmitButton(),
                    const SizedBox(height: AppConstants.spacingMedium),
                    _buildBackToLogin(),
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
            color: AppConstants.warningColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.lock_reset_rounded,
            size: AppConstants.iconSizeLarge,
            color: AppConstants.warningColor,
          ),
        ),
        const SizedBox(height: AppConstants.spacingMedium),
        const Text(
          AppStrings.forgotPasswordTitle,
          style: AppConstants.headingStyle,
        ),
        const SizedBox(height: AppConstants.spacingSmall),
        const Text(
          AppStrings.forgotPasswordSubtitle,
          style: AppConstants.subheadingStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      label: AppStrings.email,
      hint: AppStrings.forgotPasswordEmailHint,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => _handleSubmit(),
      validator: Validators.email,
    );
  }

  Widget _buildSubmitButton() {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return CustomButton(
          text: AppStrings.sendResetLink,
          isLoading: auth.isLoading,
          onPressed: _handleSubmit,
          backgroundColor: AppConstants.warningColor,
          icon: Icons.send_rounded,
        );
      },
    );
  }

  Widget _buildBackToLogin() {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text(
        AppStrings.backToSignIn,
        style: AppConstants.linkTextStyle,
      ),
    );
  }
}
