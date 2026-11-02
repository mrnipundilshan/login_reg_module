import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        final user = auth.user;

        return Scaffold(
          backgroundColor: AppConstants.backgroundLight,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              AppStrings.home,
              style: TextStyle(
                color: AppConstants.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0.5,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppConstants.maxFormWidth,
              ),
              child: Column(
                children: [
                  Container(
                    width: AppConstants.avatarSizeLarge,
                    height: AppConstants.avatarSizeLarge,
                    decoration: BoxDecoration(
                      color: AppConstants.accentColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_outline_rounded,
                      size: AppConstants.iconSizeXLarge,
                      color: AppConstants.accentColor,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingLarge),
                  Text(
                    '${AppStrings.welcome}, ${user?.fullName ?? AppStrings.username}!',
                    style: AppConstants.headingStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  const Text(
                    AppStrings.loginSuccessSubtitle,
                    style: AppConstants.subheadingStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppConstants.spacingXLarge),
                  if (user != null)
                    _buildUserInfoCard(
                      user.fullName,
                      user.email,
                      user.username,
                      user.phone ?? AppStrings.notAvailable,
                    ),
                  const SizedBox(height: AppConstants.spacingXLarge),
                  CustomButton(
                    text: AppStrings.signOut,
                    onPressed: () => _handleLogout(context, auth),
                    backgroundColor: AppConstants.errorColor,
                    icon: Icons.logout_rounded,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserInfoCard(
    String name,
    String email,
    String username,
    String phone,
  ) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        side: const BorderSide(color: AppConstants.dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          children: [
            const Text(
              AppStrings.accountDetails,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppConstants.textPrimary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            _buildInfoRow(Icons.person_outline, AppStrings.name, name),
            const Divider(height: AppConstants.spacingLarge),
            _buildInfoRow(Icons.alternate_email, AppStrings.username, username),
            const Divider(height: AppConstants.spacingLarge),
            _buildInfoRow(Icons.email_outlined, AppStrings.email, email),
            if (phone != "N/A") ...[
              const Divider(height: AppConstants.spacingLarge),
              _buildInfoRow(Icons.phone_outlined, AppStrings.phone, phone),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppConstants.iconSizeSmall,
          color: AppConstants.primaryColor,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppConstants.textSecondary,
                ),
              ),
              const SizedBox(height: AppConstants.spacingTiny),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppConstants.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleLogout(BuildContext context, AuthProvider auth) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        title: const Text(AppStrings.signOut),
        content: const Text(AppStrings.signOutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              auth.logout();
              Navigator.of(ctx).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text(
              AppStrings.signOut,
              style: TextStyle(color: AppConstants.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}
