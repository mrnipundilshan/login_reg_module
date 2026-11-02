import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/password_field.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.login(
      username: _usernameController.text.trim(),
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
                    _buildUsernameField(),
                    const SizedBox(height: AppConstants.spacingMedium),
                    _buildPasswordField(),
                    const SizedBox(height: AppConstants.spacingSmall),
                    _buildRememberForgotRow(),
                    const SizedBox(height: AppConstants.spacingLarge),
                    _buildLoginButton(),
                    const SizedBox(height: AppConstants.spacingLarge),
                    _buildDivider(),
                    const SizedBox(height: AppConstants.spacingLarge),
                    _buildRegisterLink(),
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
            color: AppConstants.primaryColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.lock_open_rounded,
            size: AppConstants.iconSizeLarge,
            color: AppConstants.primaryColor,
          ),
        ),
        const SizedBox(height: AppConstants.spacingMedium),
        const Text(AppStrings.loginTitle, style: AppConstants.headingStyle),
        const SizedBox(height: AppConstants.spacingSmall),
        const Text(
          AppStrings.loginSubtitle,
          style: AppConstants.subheadingStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildUsernameField() {
    return CustomTextField(
      controller: _usernameController,
      label: AppStrings.username,
      hint: AppStrings.usernameHint,
      prefixIcon: Icons.person_outline,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
      validator: (value) => Validators.required(value, AppStrings.username),
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
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _handleLogin(),
          validator: (value) => Validators.required(value, AppStrings.password),
        );
      },
    );
  }

  Widget _buildRememberForgotRow() {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: AppConstants.checkboxSize,
                  width: AppConstants.checkboxSize,
                  child: Checkbox(
                    value: auth.rememberMe,
                    onChanged: (value) => auth.toggleRememberMe(value ?? false),
                    activeColor: AppConstants.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadiusSmall,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.spacingSmall),
                GestureDetector(
                  onTap: () => auth.toggleRememberMe(!auth.rememberMe),
                  child: const Text(
                    AppStrings.rememberMe,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppConstants.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ForgotPasswordScreen(),
                  ),
                );
              },
              child: const Text(
                AppStrings.forgotPassword,
                style: AppConstants.linkTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return CustomButton(
          text: AppStrings.signIn,
          isLoading: auth.isLoading,
          onPressed: _handleLogin,
          icon: Icons.login_rounded,
        );
      },
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppConstants.dividerColor)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
          child: Text(
            AppStrings.orDivider,
            style: TextStyle(
              color: AppConstants.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppConstants.dividerColor)),
      ],
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          AppStrings.dontHaveAccount,
          style: TextStyle(color: AppConstants.textSecondary, fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            context.read<AuthProvider>().reset();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const RegistrationScreen()),
            );
          },
          child: const Text(
            AppStrings.signUp,
            style: AppConstants.linkTextStyle,
          ),
        ),
      ],
    );
  }
}
