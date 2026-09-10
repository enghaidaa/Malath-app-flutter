import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/quran_cubit.dart';

class SurahDetailsView extends StatefulWidget {
  final int surahId;

  const SurahDetailsView({
    super.key,
    required this.surahId,
  });

  @override
  State<SurahDetailsView> createState() => _SurahDetailsViewState();
}

class _SurahDetailsViewState extends State<SurahDetailsView> {
  @override
  void initState() {
    super.initState();

    context.read<QuranCubit>().getSurahById(
          widget.surahId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'surah_details.title'.tr(),
        ),
      ),
      body: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          // =========================
          // Loading
          // =========================
          if (state is QuranLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // =========================
          // Failure
          // =========================
          if (state is QuranFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // =========================
          // Surah Loaded
          // =========================
          if (state is SurahLoaded) {
            final surah = state.surah;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // =========================
                // Surah Name
                // =========================
                Text(
                  surah.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // =========================
                // English Name
                // =========================
                Text(
                  surah.englishName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                // =========================
                // Translation
                // =========================
                Text(
                  surah.englishNameTranslation,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // =========================
                // Ayahs Count & Revelation
                // =========================
                Text(
                  '${surah.numberOfAyahs} '
                  '${'surah_details.ayah_number'.tr()} • '
                  '${surah.revelationType}',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // =========================
                // Ayahs
                // =========================
                ...surah.ayahs.map(
                  (ayah) => Card(
                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // =========================
                          // Ayah Text
                          // =========================
                          Text(
                            ayah.text,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 22,
                              height: 2,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // =========================
                          // Ayah Number
                          // =========================
                          Text(
                            '${'surah_details.ayah_number'.tr()} '
                            '${ayah.numberInSurah}',
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
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
