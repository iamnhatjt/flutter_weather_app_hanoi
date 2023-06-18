class WeatherModel {
  final double temp;
  final double feelLike;
  final double tempMin;
  final double tempMax;
  final double pop;
  final double seaLevel;
  final double humidity;
  final String main;
  final String description;
  final double windSpeed;
  final String dateTime;

  const WeatherModel({
    required this.temp,
    required this.feelLike,
    required this.tempMin,
    required this.tempMax,
    required this.pop,
    required this.seaLevel,
    required this.humidity,
    required this.main,
    required this.description,
    required this.windSpeed,
    required this.dateTime,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: (json['main']['temp']).toDouble(),
      feelLike: (json['main']['feels_like']).toDouble(),
      tempMin: (json['main']['temp_min']).toDouble(),
      tempMax: (json['main']['temp_max']).toDouble(),
      pop: (json['pop']).toDouble(),
      seaLevel: (json['main']['sea_level']).toDouble(),
      humidity: (json['main']['humidity']).toDouble(),
      main: json['weather'][0]['main'],
      description: (json['weather'][0]['description']).toString(),
      windSpeed: (json['wind']['speed']).toDouble(),
      dateTime: json['dt_txt'].toString(),
    );
  }
}
