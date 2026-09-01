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
        title: const Text('Surah'),
      ),
      body: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is QuranLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is QuranFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state is SurahLoaded) {
            final surah = state.surah;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  surah.name,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  surah.englishName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  surah.englishNameTranslation,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  '${surah.numberOfAyahs} Ayahs • ${surah.revelationType}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
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
                          Text(
                            ayah.text,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 22,
                              height: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ayah ${ayah.numberInSurah}',
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
