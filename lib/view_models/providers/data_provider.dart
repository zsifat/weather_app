import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/weather_service.dart';
import '../weather_view_model.dart';
import '../states/weather_state.dart';
import 'package:change_case/change_case.dart';

final weatherServiceProvider = Provider((ref) => WeatherService());

final cityProvider = StateProvider<String>((ref) => 'sylhet');

final suggestionsProvider =
    StateProvider<List<Map<String, dynamic>>>((ref) => []);

final currentCityProvider = Provider<String>((ref) {
  final city = ref.watch(cityProvider);
  return city.toTitleCase();
});

final weatherViewModelProvider =
    StateNotifierProvider<WeatherViewModel, WeatherState>((ref) {
  final weatherService = ref.watch(weatherServiceProvider);
  return WeatherViewModel(weatherService);
});
