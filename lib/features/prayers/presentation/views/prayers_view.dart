import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/prayers_cubit.dart';

class PrayersView extends StatefulWidget {
  const PrayersView({super.key});

  @override
  State<PrayersView> createState() => _PrayersViewState();
}

class _PrayersViewState extends State<PrayersView> {
  @override
  void initState() {
    super.initState();

    context.read<PrayerCubit>().getPrayerTimings(
          latitude: 15.3694,
          longitude: 44.191,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times'),
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
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state is PrayerLoaded) {
            final prayerTimings = state.prayerTimings;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  prayerTimings.hijriDate,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                ListTile(
                  title: const Text('Fajr'),
                  trailing: Text(prayerTimings.fajr),
                ),
                ListTile(
                  title: const Text('Sunrise'),
                  trailing: Text(prayerTimings.sunrise),
                ),
                ListTile(
                  title: const Text('Dhuhr'),
                  trailing: Text(prayerTimings.dhuhr),
                ),
                ListTile(
                  title: const Text('Asr'),
                  trailing: Text(prayerTimings.asr),
                ),
                ListTile(
                  title: const Text('Maghrib'),
                  trailing: Text(prayerTimings.maghrib),
                ),
                ListTile(
                  title: const Text('Isha'),
                  trailing: Text(prayerTimings.isha),
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
