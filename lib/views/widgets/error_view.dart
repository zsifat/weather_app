import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_models/providers/data_provider.dart';

class ErrorView extends ConsumerWidget {
  final Object error;

  const ErrorView({super.key, required this.error});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                // Reset error and loading state
                final viewModel = ref.read(weatherViewModelProvider.notifier);
                final currentCity =
                    ref.read(cityProvider); // Use cityProvider instead
                await viewModel.fetchWeather(currentCity);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
