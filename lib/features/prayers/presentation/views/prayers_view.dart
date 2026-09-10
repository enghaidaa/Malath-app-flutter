import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes_name.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../manager/prayers_cubit.dart';

class PrayersView extends StatefulWidget {
  const PrayersView({super.key});

  @override
  State<PrayersView> createState() => _PrayersViewState();
}

class _PrayersViewState extends State<PrayersView> {
  // صفحة مواقيت الصلاة ليست ضمن عناصر الـ Bottom Navigation
  static const int currentIndex = -1;

  @override
  void initState() {
    super.initState();

    context.read<PrayerCubit>().getPrayerTimings(
          latitude: 15.3694,
          longitude: 44.191,
        );
  }

  void _onBottomNavTap(BuildContext context, int index) {
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
        Navigator.pushReplacementNamed(
          context,
          RoutesName.settings,
        );
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
        title: Text('prayers_view.app_bar_title'.tr()),
      ),
      body: BlocBuilder<PrayerCubit, PrayerState>(
        builder: (context, state) {
          if (state is PrayerLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PrayerFailure) {
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
                      state.errorMessage,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PrayerCubit>().getPrayerTimings(
                              latitude: 15.3694,
                              longitude: 44.191,
                            );
                      },
                      child: Text('prayers_view.retry_button'.tr()),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is PrayerLoaded) {
            final prayerTimings = state.prayerTimings;

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildDateCard(
                  context,
                  prayerTimings.hijriDate,
                ),
                const SizedBox(height: 20),
                Text(
                  'prayers_view.today_timings'.tr(),
                  textAlign: TextAlign.right,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildPrayerCard(
                  context,
                  title: 'prayers_view.fajr'.tr(),
                  time: prayerTimings.fajr,
                  icon: Icons.wb_twilight_outlined,
                  color: const Color(0xFFCDB4DB),
                ),
                _buildPrayerCard(
                  context,
                  title: 'prayers_view.sunrise'.tr(),
                  time: prayerTimings.sunrise,
                  icon: Icons.wb_sunny_outlined,
                  color: const Color(0xFFFFC8DD),
                ),
                _buildPrayerCard(
                  context,
                  title: 'prayers_view.dhuhr'.tr(),
                  time: prayerTimings.dhuhr,
                  icon: Icons.wb_sunny,
                  color: const Color(0xFFFFAFCC),
                ),
                _buildPrayerCard(
                  context,
                  title: 'prayers_view.asr'.tr(),
                  time: prayerTimings.asr,
                  icon: Icons.wb_sunny_outlined,
                  color: const Color(0xFFBDE0FE),
                ),
                _buildPrayerCard(
                  context,
                  title: 'prayers_view.maghrib'.tr(),
                  time: prayerTimings.maghrib,
                  icon: Icons.nights_stay_outlined,
                  color: const Color(0xFFA2D2FF),
                ),
                _buildPrayerCard(
                  context,
                  title: 'prayers_view.isha'.tr(),
                  time: prayerTimings.isha,
                  icon: Icons.nightlight_outlined,
                  color: const Color(0xFFCDB4DB),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          _onBottomNavTap(context, index);
        },
      ),
    );
  }

  Widget _buildDateCard(
    BuildContext context,
    String hijriDate,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFCDB4DB),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'prayers_view.hijri_date'.tr(),
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black87,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  hijriDate,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerCard(
    BuildContext context, {
    required String title,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: Colors.black87,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
