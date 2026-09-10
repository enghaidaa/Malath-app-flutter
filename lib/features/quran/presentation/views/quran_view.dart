import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routing/routes_name.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../manager/quran_cubit.dart';

class QuranView extends StatefulWidget {
  const QuranView({super.key});

  @override
  State<QuranView> createState() => _QuranViewState();
}

class _QuranViewState extends State<QuranView> {
  static const int currentIndex = 1;

  @override
  void initState() {
    super.initState();

    context.read<QuranCubit>().getSurahs();
  }

  void _onBottomNavTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(
          context,
          RoutesName.home,
        );
        break;

      case 1:
        break;

      case 2:
        Navigator.pushReplacementNamed(
          context,
          RoutesName.myAzkar,
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
          RoutesName.settings,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('quran.title'.tr()),
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
              return Center(
                child: Text('quran.no_surahs'.tr()),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
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
                    textAlign: TextAlign.right,
                  ),
                  subtitle: Text(
                    surah.englishName,
                  ),
                  trailing: Text(
                    '${surah.numberOfAyahs} ${'quran.ayah_suffix'.tr()}',
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
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(
                context,
                RoutesName.home,
              );
              break;

            case 1:
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
        },
      ),
    );
  }
}
