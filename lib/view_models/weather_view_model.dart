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
          isLoading: true,
        )) {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      final isDark =
          PlatformDispatcher.instance.platformBrightness == Brightness.dark;
      setDarkMode(isDark);
    };
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      final response = await _weatherService.fetchWeather(state.currentCity);
      final weatherData = WeatherModel.fromJson(response);
      state = state.copyWith(
        weather: weatherData,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      String errorMessage = 'Please check your internet connection';
      if (e.toString().contains('SocketException')) {
        errorMessage = 'No internet connection. Please check your network.';
      }
      state = state.copyWith(
        isLoading: false,
        error: errorMessage,
      );
    }
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
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _weatherService.fetchWeather(city);
      final weatherData = WeatherModel.fromJson(response);
      state = state.copyWith(
        weather: weatherData,
        currentCity: city,
        isLoading: false,
        suggestions: [],
        error: null,
      );
    } catch (e) {
      print('Error in fetchWeather: $e');
      String errorMessage;
      if (e.toString().contains('SocketException')) {
        errorMessage = 'No internet connection. Please check your network.';
      } else if (e.toString().contains('timed out')) {
        errorMessage = 'Request timed out. Please try again.';
      } else if (e.toString().contains('Failed to load weather data')) {
        errorMessage = 'Unable to fetch weather data. Please try again later.';
      } else {
        errorMessage = 'An error occurred. Please try again.';
      }
      state = state.copyWith(
        isLoading: false,
        error: errorMessage,
      );
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
