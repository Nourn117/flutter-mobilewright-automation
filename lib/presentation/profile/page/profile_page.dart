import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/testing/test_ids.dart';
import 'package:mobilewright_demo_app/core/theme/theme_cubit.dart';
import 'package:mobilewright_demo_app/core/widgets/test_id.dart';
import 'package:mobilewright_demo_app/domain/entities/authentication/app_user.dart';
import 'package:mobilewright_demo_app/presentation/cart/cubit/cart_cubit.dart';
import 'package:mobilewright_demo_app/presentation/common/cubit/session_cubit.dart';
import 'package:mobilewright_demo_app/presentation/home/cubit/home_tab_cubit.dart';
import 'package:mobilewright_demo_app/presentation/login/page/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    final session = context.read<SessionCubit>();
    final cart = context.read<CartCubit>();
    final theme = context.read<ThemeCubit>();
    final tabs = context.read<HomeTabCubit>();
    final navigator = Navigator.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.logout_rounded, size: 36),
        title: const Text('Log out?'),
        content: const Text('Your cart will be cleared.'),
        actions: [
          TestId(
            TestIds.profileCancelLogout,
            child: TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
          ),
          TestId(
            TestIds.profileConfirmLogout,
            child: FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Log out'),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    await session.logout();
    cart.clear();
    theme.setDark(false);
    tabs.select(HomeTab.products);
    navigator.pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<SessionCubit, AppUser?>(
        builder: (context, user) {
          final name = user?.name ?? '';
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: scheme.primaryContainer,
                        child: Text(
                          name.isEmpty ? '?' : name[0].toUpperCase(),
                          style: text.headlineSmall?.copyWith(
                            color: scheme.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TestId(
                              TestIds.profileName,
                              child: Text(name,
                                  style: text.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w800)),
                            ),
                            const SizedBox(height: 2),
                            TestId(
                              TestIds.profileEmail,
                              child: Text(user?.email ?? '',
                                  style: text.bodyMedium?.copyWith(
                                      color: scheme.onSurfaceVariant)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, mode) => TestId(
                    TestIds.profileDarkMode,
                    child: SwitchListTile(
                      secondary: const Icon(Icons.dark_mode_outlined),
                      title: const Text('Dark mode'),
                      value: mode == ThemeMode.dark,
                      onChanged: context.read<ThemeCubit>().setDark,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: TestId(
                  TestIds.profileLogout,
                  child: ListTile(
                    leading: Icon(Icons.logout_rounded, color: scheme.error),
                    title: Text('Log out',
                        style: TextStyle(
                            color: scheme.error, fontWeight: FontWeight.w600)),
                    onTap: () => _logout(context),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
