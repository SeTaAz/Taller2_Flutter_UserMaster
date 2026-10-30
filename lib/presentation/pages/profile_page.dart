import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../domain/entities/user_profile.dart';
import '../../core/widgets/app_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({required this.profile, required this.onLogout, super.key});

  final UserProfile profile;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 56,
                backgroundColor: AppColors.secondary.withValues(alpha: 0.12),
                child: const Icon(
                  Icons.person,
                  size: 64,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                profile.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                profile.email,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              AppButton(
                key: const Key('logout-button'),
                label: 'Cerrar sesión',
                onPressed: onLogout,
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
