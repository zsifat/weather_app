import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:change_case/change_case.dart';
import '../../view_models/weather_view_model.dart';
import '../../view_models/states/weather_state.dart';
import '../../utils/weather_utils.dart';
import 'forecast_today_card.dart';
import 'seven_day_forecast_card.dart';

class WeatherView extends StatelessWidget {
  final WeatherState state;
  final WeatherViewModel viewModel;

  const WeatherView({
    super.key,
    required this.state,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final weather = state.weather;

    Size size = MediaQuery.of(context).size;
    final hourlyForecast = weather!.forecast.forecastday[0].hour
        .where((hour) => DateTime.now().hour <= DateTime.parse(hour.time).hour)
        .toList();

    return Center(
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: state.isDarkMode ? Colors.black : Colors.white,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search TextField
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.05,
                  ),
                  child: TextField(
                    style: GoogleFonts.questrial(
                      color: state.isDarkMode
                          ? Colors.white.withOpacity(0.8)
                          : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter city name',
                      hintStyle: GoogleFonts.questrial(
                        color: state.isDarkMode
                            ? Colors.white.withOpacity(0.8)
                            : Colors.black,
                      ),
                      filled: true,
                      fillColor: state.isDarkMode
                          ? Colors.blueAccent.withOpacity(0.2)
                          : const Color.fromARGB(172, 243, 240, 240),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon:
                          const Icon(Icons.search, color: Colors.blueAccent),
                    ),
                    onChanged: (value) => viewModel.getSuggestions(value),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        viewModel.fetchWeather(value.trim());
                        viewModel.clearSuggestions();
                      }
                    },
                  ),
                ),

                // After the TextField widget
                if (state.suggestions.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.05,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: state.isDarkMode
                            ? Colors.black
                            : Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 100,
                      child: ListView.builder(
                        itemCount: state.suggestions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              state.suggestions[index]['name'],
                              style: GoogleFonts.questrial(
                                color: state.isDarkMode
                                    ? Colors.white.withOpacity(0.8)
                                    : Colors.black,
                              ),
                            ),
                            onTap: () {
                              final selectedCity =
                                  state.suggestions[index]['name'];
                              viewModel.fetchWeather(selectedCity);
                              viewModel.clearSuggestions();
                            },
                          );
                        },
                      ),
                    ),
                  ),

                // City name
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.01),
                  child: Align(
                    child: Text(
                      state.currentCity.toTitleCase(),
                      style: GoogleFonts.questrial(
                        color: state.isDarkMode ? Colors.white : Colors.black,
                        fontSize: size.height * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Today text
                Align(
                  child: Text(
                    'Today',
                    style: GoogleFonts.questrial(
                      color: state.isDarkMode ? Colors.white54 : Colors.black54,
                      fontSize: size.height * 0.037,
                    ),
                  ),
                ),
                // Temperature
                Align(
                  child: Text(
                    '${weather.current.tempC.round()}˚C',
                    style: GoogleFonts.questrial(
                      color: WeatherUtils.getTemperatureColor(
                        weather.current.tempC.round(),
                      ),
                      fontSize: size.height * 0.13,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.white.withOpacity(0.2),
                  thickness: 1.5,
                  indent: size.width * 0.20,
                  endIndent: size.width * 0.20,
                ),

                // Weather condition
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.003),
                  child: Align(
                    child: Text(
                      weather.current.condition.text,
                      style: GoogleFonts.questrial(
                        color:
                            state.isDarkMode ? Colors.white54 : Colors.black54,
                        fontSize: size.height * 0.035,
                      ),
                    ),
                  ),
                ),

                // Min-Max temperature
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.03,
                    bottom: size.height * 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${weather.forecast.forecastday[0].day.mintempC.round()}˚C',
                        style: GoogleFonts.questrial(
                          color: WeatherUtils.getTemperatureColor(
                            weather.forecast.forecastday[0].day.mintempC
                                .round(),
                          ),
                          fontSize: size.height * 0.035,
                        ),
                      ),
                      Text(
                        ' ~ ',
                        style: GoogleFonts.questrial(
                          color: state.isDarkMode
                              ? Colors.white54
                              : Colors.black54,
                          fontSize: size.height * 0.035,
                        ),
                      ),
                      Text(
                        '${weather.forecast.forecastday[0].day.maxtempC.round()}˚C',
                        style: GoogleFonts.questrial(
                          color: WeatherUtils.getTemperatureColor(
                            weather.forecast.forecastday[0].day.maxtempC
                                .round(),
                          ),
                          fontSize: size.height * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),

                // Hourly forecast
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: state.isDarkMode
                          ? Colors.white.withOpacity(0.05)
                          : Colors.black.withOpacity(0.05),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.01,
                              left: size.width * 0.03,
                            ),
                            child: Text(
                              'Forecast for today',
                              style: GoogleFonts.questrial(
                                color: state.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: size.height * 0.025,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.3,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: hourlyForecast.length,
                            itemBuilder: (context, index) {
                              final hour = hourlyForecast[index];
                              return ForecastTodayCard(
                                time: index == 0
                                    ? 'Now'
                                    : DateFormat('HH:mm')
                                        .format(DateTime.parse(hour.time)),
                                temp: hour.tempC.round(),
                                wind: hour.windKph.round(),
                                rainChance: hour.chanceOfRain,
                                weatherIcon: WeatherUtils.getWeatherIcon(
                                    hour.condition.text),
                                size: size,
                                isDarkMode: state.isDarkMode,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 7-day forecast
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.02,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.05),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.02,
                              left: size.width * 0.03,
                            ),
                            child: Text(
                              '7-day forecast',
                              style: GoogleFonts.questrial(
                                color: state.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: size.height * 0.025,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: state.isDarkMode ? Colors.white : Colors.black,
                        ),
                        Column(
                          children: weather.forecast.forecastday
                              .map((day) => SevenDayForecastCard(
                                    day: day == weather.forecast.forecastday[0]
                                        ? 'Today'
                                        : WeatherUtils.getDayName(
                                            day.dateEpoch),
                                    minTemp: day.day.mintempC.round(),
                                    maxTemp: day.day.maxtempC.round(),
                                    weatherIcon: WeatherUtils.getWeatherIcon(
                                        day.day.condition.text),
                                    size: size,
                                    isDarkMode: state.isDarkMode,
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
