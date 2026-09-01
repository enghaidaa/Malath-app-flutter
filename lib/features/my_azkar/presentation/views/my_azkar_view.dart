import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/my_azkar_cubit.dart';

class MyAzkarView extends StatefulWidget {
  const MyAzkarView({super.key});

  @override
  State<MyAzkarView> createState() => _MyAzkarViewState();
}

class _MyAzkarViewState extends State<MyAzkarView> {
  @override
  void initState() {
    super.initState();

    context.read<MyAzkarCubit>().getMyAzkar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Azkar'),
      ),
      body: BlocBuilder<MyAzkarCubit, MyAzkarState>(
        builder: (context, state) {
          if (state is MyAzkarLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MyAzkarFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state is MyAzkarLoaded) {
            if (state.azkar.isEmpty) {
              return const Center(
                child: Text('No Azkar saved'),
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
                        Text(
                          azkar.text,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 22,
                            height: 2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Repetitions: ${azkar.repetitions}',
                        ),
                        const SizedBox(height: 8),
                        Text(
                          azkar.reference,
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<MyAzkarCubit>()
                                  .deleteAzkar(azkar.id);
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
    );
  }
}
