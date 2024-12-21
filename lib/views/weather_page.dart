import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/providers/data_provider.dart';
import '../views/widgets/weather_view.dart';
import '../views/widgets/error_view.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weatherViewModelProvider);
    final viewModel = ref.read(weatherViewModelProvider.notifier);

    return Scaffold(
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            )
          : state.error != null
              ? ErrorView(error: state.error!)
              : WeatherView(
                  state: state,
                  viewModel: viewModel,
                ),
    );
  }
}
