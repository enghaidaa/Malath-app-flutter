import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: const Text('Prayer Tracker'),
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
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state is PrayerTrackerLoaded) {
            final tracker = state.tracker;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  date,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildPrayerTile(
                  context,
                  title: 'Fajr',
                  prayer: 'fajr',
                  isPrayed: tracker.fajr,
                ),
                _buildPrayerTile(
                  context,
                  title: 'Dhuhr',
                  prayer: 'dhuhr',
                  isPrayed: tracker.dhuhr,
                ),
                _buildPrayerTile(
                  context,
                  title: 'Asr',
                  prayer: 'asr',
                  isPrayed: tracker.asr,
                ),
                _buildPrayerTile(
                  context,
                  title: 'Maghrib',
                  prayer: 'maghrib',
                  isPrayed: tracker.maghrib,
                ),
                _buildPrayerTile(
                  context,
                  title: 'Isha',
                  prayer: 'isha',
                  isPrayed: tracker.isha,
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildPrayerTile(
    BuildContext context, {
    required String title,
    required String prayer,
    required bool isPrayed,
  }) {
    return Card(
      child: SwitchListTile(
        title: Text(title),
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
