import '../../models/weather_model.dart';

class WeatherState {
  final bool isDarkMode;
  final String currentCity;
  final List<Map<String, dynamic>> suggestions;
  final bool isLoading;
  final WeatherModel? weather;
  final String? error;

  WeatherState({
    required this.isDarkMode,
    required this.currentCity,
    required this.suggestions,
    this.isLoading = false,
    this.weather,
    this.error,
  });

  WeatherState copyWith({
    bool? isDarkMode,
    String? currentCity,
    List<Map<String, dynamic>>? suggestions,
    bool? isLoading,
    WeatherModel? weather,
    String? error,
  }) {
    return WeatherState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      currentCity: currentCity ?? this.currentCity,
      suggestions: suggestions ?? this.suggestions,
      isLoading: isLoading ?? this.isLoading,
      weather: weather ?? this.weather,
      error: error ?? this.error,
    );
  }
}
