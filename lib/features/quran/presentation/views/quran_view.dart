import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routing/routes_name.dart';
import '../manager/quran_cubit.dart';

class QuranView extends StatefulWidget {
  const QuranView({super.key});

  @override
  State<QuranView> createState() => _QuranViewState();
}

class _QuranViewState extends State<QuranView> {
  @override
  void initState() {
    super.initState();

    context.read<QuranCubit>().getSurahs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran'),
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

          if (state is QuranLoaded) {
            if (state.surahs.isEmpty) {
              return const Center(
                child: Text('No Surahs available'),
              );
            }

            return ListView.builder(
              itemCount: state.surahs.length,
              itemBuilder: (context, index) {
                final surah = state.surahs[index];

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      '${surah.number}',
                    ),
                  ),
                  title: Text(
                    surah.name,
                    textDirection: TextDirection.rtl,
                  ),
                  subtitle: Text(
                    surah.englishName,
                  ),
                  trailing: Text(
                    '${surah.numberOfAyahs} Ayahs',
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.surahDetails,
                      arguments: surah.number,
                    );
                  },
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
