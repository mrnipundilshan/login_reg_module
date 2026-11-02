import 'package:flutter/material.dart';

import '../utils/constants.dart';

class LoadingOverlay extends StatelessWidget {
  final String? message;

  const LoadingOverlay({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusCard),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingXLarge,
              vertical: AppConstants.paddingLarge,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                if (message != null) ...[
                  const SizedBox(height: AppConstants.spacingMedium),
                  Text(
                    message!,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
