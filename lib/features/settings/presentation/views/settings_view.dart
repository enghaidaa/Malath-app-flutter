import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsInitial || state is SettingsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SettingsFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.errorMessage}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SettingsCubit>().loadSettings();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is SettingsLoaded) {
            final settings = state.settings;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Theme Setting
                ListTile(
                  title: const Text('Dark Mode'),
                  subtitle: Text(
                    settings.isDarkMode ? 'Enabled' : 'Disabled',
                  ),
                  trailing: Switch(
                    value: settings.isDarkMode,
                    onChanged: (value) {
                      context.read<SettingsCubit>().toggleTheme();
                    },
                  ),
                ),
                const Divider(),
                // Language Setting
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Language',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButton<String>(
                        value: settings.languageCode,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(
                            value: 'en',
                            child: Text('English'),
                          ),
                          DropdownMenuItem(
                            value: 'ar',
                            child: Text('العربية'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            context
                                .read<SettingsCubit>()
                                .changeLanguage(value);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(),
                // Font Size Setting
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Font Size: ${settings.fontSize.toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
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
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('14.0'),
                            Text('32.0'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
