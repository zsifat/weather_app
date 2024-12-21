import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../view_models/states/weather_state.dart';

class WeatherViewModel extends StateNotifier<WeatherState> {
  final WeatherService _weatherService;

  WeatherViewModel(this._weatherService)
      : super(WeatherState(
          isDarkMode:
              PlatformDispatcher.instance.platformBrightness == Brightness.dark,
          currentCity: 'sylhet',
          suggestions: [],
        )) {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      final isDark =
          PlatformDispatcher.instance.platformBrightness == Brightness.dark;
      setDarkMode(isDark);
    };
    fetchWeather('sylhet');
  }

  void setDarkMode(bool isDarkMode) {
    state = state.copyWith(isDarkMode: isDarkMode);
  }

  @override
  void dispose() {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = null;
    super.dispose();
  }

  Future<void> fetchWeather(String city) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _weatherService.fetchWeather(city);
      final weatherData = WeatherModel.fromJson(response);
      state = state.copyWith(
        weather: weatherData,
        currentCity: city,
        isLoading: false,
        suggestions: [],
      );
      clearSuggestions();
    } catch (e, stack) {
      print('Error fetching weather: $e\n$stack');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> getSuggestions(String query) async {
    if (query.isEmpty) {
      clearSuggestions();
      return;
    }
    try {
      final suggestions = await _weatherService.getSearchSugestions(query);
      state = state.copyWith(
        suggestions: suggestions,
      );
    } catch (e) {
      print('Error getting suggestions: $e');
      clearSuggestions();
    }
  }

  void clearSuggestions() {
    state = state.copyWith(suggestions: []);
  }
}
