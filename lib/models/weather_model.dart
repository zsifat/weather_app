class WeatherModel {
  final Current current;
  final Forecast forecast;

  WeatherModel({
    required this.current,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    print('Parsing weather data: $json');
    return WeatherModel(
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }
}

class Current {
  final double tempC;
  final Condition condition;

  Current({
    required this.tempC,
    required this.condition,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: json['temp_c'].toDouble(),
      condition: Condition.fromJson(json['condition']),
    );
  }
}

class Forecast {
  final List<ForecastDay> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastday: List<ForecastDay>.from(
        json['forecastday'].map((x) => ForecastDay.fromJson(x)),
      ),
    );
  }
}

class ForecastDay {
  final int dateEpoch;
  final Day day;
  final List<Hour> hour;

  ForecastDay({
    required this.dateEpoch,
    required this.day,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      dateEpoch: json['date_epoch'],
      day: Day.fromJson(json['day']),
      hour: List<Hour>.from(json['hour'].map((x) => Hour.fromJson(x))),
    );
  }
}

class Day {
  final double maxtempC;
  final double mintempC;
  final Condition condition;

  Day({
    required this.maxtempC,
    required this.mintempC,
    required this.condition,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: json['maxtemp_c'].toDouble(),
      mintempC: json['mintemp_c'].toDouble(),
      condition: Condition.fromJson(json['condition']),
    );
  }
}

class Hour {
  final String time;
  final double tempC;
  final double windKph;
  final int chanceOfRain;
  final Condition condition;

  Hour({
    required this.time,
    required this.tempC,
    required this.windKph,
    required this.chanceOfRain,
    required this.condition,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      time: json['time'],
      tempC: json['temp_c'].toDouble(),
      windKph: json['wind_kph'].toDouble(),
      chanceOfRain: json['chance_of_rain'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}

class Condition {
  final String text;

  Condition({required this.text});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
    );
  }
}
