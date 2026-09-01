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
        title: const Text('Azkar'),
      ),
      body: BlocBuilder<AzkarCubit, AzkarState>(
        builder: (context, state) {
          if (state is AzkarLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AzkarFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state is AzkarLoaded) {
            if (state.azkar.isEmpty) {
              return const Center(
                child: Text('No Azkar available'),
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
                    '${azkar.items.length} Azkar',
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
                          Text(
                            item.text,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 22,
                              height: 2,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Repetitions: ${item.repetitions}',
                          ),
                          const SizedBox(height: 8),
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
