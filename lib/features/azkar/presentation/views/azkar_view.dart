import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'azkar_view.app_bar_title'.tr(),
        ),
      ),
      body: BlocBuilder<AzkarCubit, AzkarState>(
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
                  (item) => Card(
                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
