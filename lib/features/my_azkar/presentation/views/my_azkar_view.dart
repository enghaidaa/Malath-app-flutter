import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes_name.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../data/models/my_azkar_model.dart';
import '../manager/my_azkar_cubit.dart';

class MyAzkarView extends StatefulWidget {
  const MyAzkarView({super.key});

  @override
  State<MyAzkarView> createState() => _MyAzkarViewState();
}

class _MyAzkarViewState extends State<MyAzkarView> {
  static const int currentIndex = 4;

  @override
  void initState() {
    super.initState();
    context.read<MyAzkarCubit>().getMyAzkar();
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
        break;
    }
  }

  void _showAddAzkarDialog(BuildContext context) {
    final cubit = context.read<MyAzkarCubit>();
    final formKey = GlobalKey<FormState>();
    final textController = TextEditingController();
    final repetitionsController = TextEditingController(text: '33');
    final referenceController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            'my_azkar_view.add_azkar'.tr(),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: textController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'my_azkar_view.zikr_text'.tr(),
                      hintText: 'my_azkar_view.zikr_text'.tr(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'my_azkar_view.required'.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: repetitionsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'my_azkar_view.repetitions'.tr(),
                      hintText: '33',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'my_azkar_view.required'.tr();
                      }
                      final number = int.tryParse(value.trim());
                      if (number == null || number <= 0) {
                        return 'my_azkar_view.enter_valid_repetitions'.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: referenceController,
                    decoration: InputDecoration(
                      labelText: 'my_azkar_view.reference'.tr(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'my_azkar_view.cancel'.tr(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final newAzkar = MyAzkarModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    category: 'custom',
                    text: textController.text.trim(),
                    translation: '',
                    transliteration: '',
                    repetitions: int.parse(repetitionsController.text.trim()),
                    benefit: '',
                    reference: referenceController.text.trim(),
                  );
                  cubit.addAzkar(newAzkar);
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'my_azkar_view.added_successfully'.tr(),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text(
                'my_azkar_view.add'.tr(),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'my_azkar_view.app_bar_title'.tr(),
        ),
      ),

      body: BlocBuilder<MyAzkarCubit, MyAzkarState>(
        builder: (context, state) {
          // =========================
          // Loading
          // =========================
          if (state is MyAzkarLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // =========================
          // Failure
          // =========================
          if (state is MyAzkarFailure) {
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
          // My Azkar
          // =========================
          if (state is MyAzkarLoaded) {
            if (state.azkar.isEmpty) {
              return Center(
                child: Text(
                  'my_azkar_view.empty_azkar'.tr(),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.azkar.length,
              itemBuilder: (context, index) {
                final azkar = state.azkar[index];

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
                        // Zekr Text
                        // =========================
                        Text(
                          azkar.text,
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
                          'my_azkar_view.repetitions_label'.tr(
                            namedArgs: {
                              'count': '${azkar.repetitions}',
                            },
                          ),
                        ),

                        const SizedBox(height: 8),

                        // =========================
                        // Reference
                        // =========================
                        Text(
                          azkar.reference,
                        ),

                        const SizedBox(height: 8),

                        // =========================
                        // Delete Button
                        // =========================
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<MyAzkarCubit>()
                                  .deleteAzkar(azkar.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'my_azkar_view.deleted_successfully'.tr(),
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),

      // =========================
      // Floating Action Button
      // =========================
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAzkarDialog(context);
        },
        tooltip: 'my_azkar_view.add_azkar'.tr(),
        child: const Icon(Icons.add),
      ),

      // =========================
      // Bottom Navigation
      // =========================
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          _onBottomNavTap(context, index);
        },
      ),
    );
  }
}
