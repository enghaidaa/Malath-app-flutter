import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes_name.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../manager/prayer_tracker_cubit.dart';

class PrayerTrackerView extends StatefulWidget {
  const PrayerTrackerView({super.key});

  @override
  State<PrayerTrackerView> createState() => _PrayerTrackerViewState();
}

class _PrayerTrackerViewState extends State<PrayerTrackerView> {
  late final String date;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();

    date =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    context.read<PrayerTrackerCubit>().getPrayerTracker(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('prayer_tracker_view.app_bar_title'.tr()),
      ),
      body: BlocBuilder<PrayerTrackerCubit, PrayerTrackerState>(
        builder: (context, state) {
          if (state is PrayerTrackerLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PrayerTrackerFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (state is PrayerTrackerLoaded) {
            final tracker = state.tracker;

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildHeader(context),
                const SizedBox(height: 20),
                _buildDateCard(context),
                const SizedBox(height: 20),
                _buildProgressCard(context, tracker),
                const SizedBox(height: 24),
                Text(
                  'prayer_tracker_view.today_prayers'.tr(),
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                _buildPrayerTile(
                  context,
                  title: 'prayer_tracker_view.fajr'.tr(),
                  prayer: 'fajr',
                  isPrayed: tracker.fajr,
                  icon: Icons.wb_twilight_outlined,
                ),
                _buildPrayerTile(
                  context,
                  title: 'prayer_tracker_view.dhuhr'.tr(),
                  prayer: 'dhuhr',
                  isPrayed: tracker.dhuhr,
                  icon: Icons.wb_sunny_outlined,
                ),
                _buildPrayerTile(
                  context,
                  title: 'prayer_tracker_view.asr'.tr(),
                  prayer: 'asr',
                  isPrayed: tracker.asr,
                  icon: Icons.wb_sunny,
                ),
                _buildPrayerTile(
                  context,
                  title: 'prayer_tracker_view.maghrib'.tr(),
                  prayer: 'maghrib',
                  isPrayed: tracker.maghrib,
                  icon: Icons.nightlight_outlined,
                ),
                _buildPrayerTile(
                  context,
                  title: 'prayer_tracker_view.isha'.tr(),
                  prayer: 'isha',
                  isPrayed: tracker.isha,
                  icon: Icons.nights_stay_outlined,
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 3,
        onTap: (index) {
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
              break;

            case 4:
              Navigator.pushReplacementNamed(
                context,
                RoutesName.myAzkar,
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'prayer_tracker_view.header_title'.tr(),
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'prayer_tracker_view.header_subtitle'.tr(),
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildDateCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.calendar_today_outlined,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'prayer_tracker_view.today_date'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(
    BuildContext context,
    dynamic tracker,
  ) {
    final prayers = [
      tracker.fajr,
      tracker.dhuhr,
      tracker.asr,
      tracker.maghrib,
      tracker.isha,
    ];

    final prayedCount = prayers.where((prayed) => prayed == true).length;
    final progress = prayedCount / 5;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '$prayedCount / 5',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              Text(
                'prayer_tracker_view.today_progress'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            prayedCount == 5
                ? 'prayer_tracker_view.completed_all_prayers'.tr()
                : 'prayer_tracker_view.keep_going'.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTile(
    BuildContext context, {
    required String title,
    required String prayer,
    required bool isPrayed,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isPrayed
            ? colorScheme.primaryContainer
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isPrayed
              ? colorScheme.primary.withValues(alpha: 0.25)
              : Theme.of(context).dividerColor,
        ),
      ),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        secondary: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isPrayed
                ? colorScheme.primary.withValues(alpha: 0.15)
                : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color:
                isPrayed ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
        ),
        title: Text(
          title,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          isPrayed
              ? 'prayer_tracker_view.prayed_status'.tr()
              : 'prayer_tracker_view.not_prayed_status'.tr(),
          textAlign: TextAlign.right,
        ),
        value: isPrayed,
        onChanged: (value) {
          context.read<PrayerTrackerCubit>().updatePrayer(
                date: date,
                prayer: prayer,
                isPrayed: value,
              );
        },
      ),
    );
  }
}
