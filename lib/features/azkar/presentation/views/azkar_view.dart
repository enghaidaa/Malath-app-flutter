import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../my_azkar/data/models/my_azkar_model.dart';
import '../../../my_azkar/presentation/manager/my_azkar_cubit.dart';
import '../manager/azkar_cubit.dart';

class AzkarView extends StatefulWidget {
  const AzkarView({super.key});

  @override
  State<AzkarView> createState() => _AzkarViewState();
}

class _AzkarViewState extends State<AzkarView> {
  @override
  void initState() {
    super.initState();
    context.read<AzkarCubit>().getAzkar();
    context.read<MyAzkarCubit>().getMyAzkar();
  }

  @override
  Widget build(BuildContext context) {
    final isCategoryLoaded =
        context.watch<AzkarCubit>().state is AzkarCategoryLoaded;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'azkar_view.app_bar_title'.tr(),
        ),
        leading: isCategoryLoaded
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<AzkarCubit>().getAzkar();
                },
              )
            : null,
      ),
      body: PopScope(
        canPop: !isCategoryLoaded,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          if (context.read<AzkarCubit>().state is AzkarCategoryLoaded) {
            context.read<AzkarCubit>().getAzkar();
          }
        },
        child: BlocBuilder<AzkarCubit, AzkarState>(
          builder: (context, state) {
            // =========================
            // Loading
            // =========================
            if (state is AzkarLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // =========================
            // Failure
            // =========================
            if (state is AzkarFailure) {
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
            // All Azkar Categories
            // =========================
            if (state is AzkarLoaded) {
              if (state.azkar.isEmpty) {
                return Center(
                  child: Text(
                    'azkar_view.empty_state'.tr(),
                  ),
                );
              }

              return ListView.builder(
                itemCount: state.azkar.length,
                itemBuilder: (context, index) {
                  final azkar = state.azkar[index];

                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        '${azkar.id}',
                      ),
                    ),
                    title: Text(
                      azkar.category,
                    ),
                    subtitle: Text(
                      '${azkar.items.length} '
                      '${'azkar_view.azkar_count'.tr()}',
                    ),
                    onTap: () {
                      context.read<AzkarCubit>().getAzkarByCategory(
                            azkar.slug,
                          );
                    },
                  );
                },
              );
            }

            // =========================
            // Azkar By Category
            // =========================
            if (state is AzkarCategoryLoaded) {
              final azkar = state.azkar;

              return BlocBuilder<MyAzkarCubit, MyAzkarState>(
                builder: (context, myAzkarState) {
                  final savedList = myAzkarState is MyAzkarLoaded
                      ? myAzkarState.azkar
                      : <MyAzkarModel>[];

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        azkar.category,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...azkar.items.map(
                        (item) {
                          final targetId = (azkar.id * 10000) + item.id;
                          final savedItem =
                              savedList.cast<MyAzkarModel?>().firstWhere(
                                    (saved) =>
                                        saved?.id == targetId ||
                                        saved?.id == item.id ||
                                        saved?.text == item.text,
                                    orElse: () => null,
                                  );
                          final isSaved = savedItem != null;

                          return Card(
                            margin: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // =========================
                                  // Heart Button (Favorite)
                                  // =========================
                                  Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: IconButton(
                                      icon: Icon(
                                        isSaved
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isSaved
                                            ? AppColors.accent
                                            : null,
                                      ),
                                      onPressed: () {
                                        if (isSaved) {
                                          context
                                              .read<MyAzkarCubit>()
                                              .deleteAzkar(savedItem.id);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'azkar_view.removed_from_my_azkar'
                                                    .tr(),
                                              ),
                                              duration:
                                                  const Duration(seconds: 1),
                                            ),
                                          );
                                        } else {
                                          final newAzkar = MyAzkarModel(
                                            id: targetId,
                                            category: azkar.category,
                                            text: item.text,
                                            translation: item.translation,
                                            transliteration:
                                                item.transliteration,
                                            repetitions: item.repetitions,
                                            benefit: item.benefit,
                                            reference: item.reference,
                                          );
                                          context
                                              .read<MyAzkarCubit>()
                                              .addAzkar(newAzkar);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'azkar_view.added_to_my_azkar'
                                                    .tr(),
                                              ),
                                              duration:
                                                  const Duration(seconds: 1),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),

                                  // =========================
                                  // Zekr Text
                                  // =========================
                                  Text(
                                    item.text,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      height: 2,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // =========================
                                  // Repetitions
                                  // =========================
                                  Text(
                                    'azkar_view.repetitions_label'.tr(
                                      namedArgs: {
                                        'count': '${item.repetitions}',
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // =========================
                                  // Reference
                                  // =========================
                                  Text(
                                    item.reference,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
