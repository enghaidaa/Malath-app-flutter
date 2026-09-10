import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes_name.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../manager/settings_cubit.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsCubit>().loadSettings();
  }

  void _onNavigationTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(
          context,
          RoutesName.home,
        );
        break;

      case 1:
        Navigator.pushReplacementNamed(
          context,
          RoutesName.quran,
        );
        break;

      case 2:
        // Already on Settings.
        break;

      case 3:
        Navigator.pushReplacementNamed(
          context,
          RoutesName.prayerTracker,
        );
        break;

      case 4:
        Navigator.pushReplacementNamed(
          context,
          RoutesName.myAzkar,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr()),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsInitial || state is SettingsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SettingsFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'settings.error_title'.tr(),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SettingsCubit>().loadSettings();
                      },
                      child: Text('settings.retry'.tr()),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is SettingsLoaded) {
            final settings = state.settings;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // =========================
                // Appearance
                // =========================
                Text(
                  'settings.appearance'.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 8),

                Card(
                  child: SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    secondary: Icon(
                      settings.isDarkMode
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                    ),
                    title: Text('settings.dark_mode'.tr()),
                    subtitle: Text(
                      settings.isDarkMode
                          ? 'settings.dark_active'.tr()
                          : 'settings.light_active'.tr(),
                    ),
                    value: settings.isDarkMode,
                    onChanged: (_) {
                      context.read<SettingsCubit>().toggleTheme();
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // =========================
                // Language
                // =========================
                Text(
                  'settings.language'.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 8),

                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.language_outlined,
                    ),
                    title: Text('settings.app_language'.tr()),
                    subtitle: Text(
                      settings.languageCode == 'ar'
                          ? 'settings.arabic'.tr()
                          : 'settings.english'.tr(),
                    ),
                    trailing: DropdownButton<String>(
                      value: settings.languageCode,
                      underline: const SizedBox(),
                      items: [
                        DropdownMenuItem(
                          value: 'ar',
                          child: Text('settings.arabic'.tr()),
                        ),
                        DropdownMenuItem(
                          value: 'en',
                          child: Text('settings.english'.tr()),
                        ),
                      ],
                      onChanged: (value) async {
                        if (value != null) {
                          await context.setLocale(Locale(value));
                          if (context.mounted) {
                            context.read<SettingsCubit>().changeLanguage(value);
                          }
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // =========================
                // Font Size
                // =========================
                Text(
                  'settings.font_size'.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 8),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.text_fields_outlined,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'settings.font_size'.tr(),
                            ),
                            const Spacer(),
                            Text(
                              settings.fontSize.toStringAsFixed(1),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Slider(
                          min: 14.0,
                          max: 32.0,
                          divisions: 18,
                          value: settings.fontSize,
                          onChanged: (value) {
                            context.read<SettingsCubit>().updateFontSize(value);
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('14'),
                              Text('32'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // =========================
                // About
                // =========================
                Text(
                  'settings.about_app'.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 8),

                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.auto_awesome_outlined,
                    ),
                    title: Text('settings.app_name'.tr()),
                    subtitle: Text(
                      'settings.app_description'.tr(),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: Text(
                    'settings.app_name'.tr(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),

      // =========================
      // Bottom Navigation
      // =========================
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          _onNavigationTap(context, index);
        },
      ),
    );
  }
}
