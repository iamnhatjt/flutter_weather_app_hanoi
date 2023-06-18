import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_company/model/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  String apiKey = 'cb6746ce8f1cc0e5e99b7d25afb47fe2';
  String idCity = '1581130';

  List<WeatherModel> listWeather = [];

  late WeatherModel selectedWeatherModel;
  int indexSelected = 0;
  int indexSelectedDate = 0;

  bool isGoodApi = false;

  final dio = Dio();

  WeatherProvider() {
    fetchWeatherApi();
  }

  Future<void> fetchWeatherApi() async {
    final response = await dio.get(
        'https://api.openweathermap.org/data/2.5/forecast?id=$idCity&cnt=56&appid=$apiKey');

    isGoodApi = response.data['cod'].toString() == '200';
    notifyListeners();
    if (!isGoodApi) {
      return;
    }

    for (var a in response.data['list']) {
      listWeather.add(WeatherModel.fromJson(a));
    }
    selectedWeatherModel = listWeather[indexSelected];
  }

  List<WeatherModel> listDayWeathers({int dayFromNow = 0}) {
    String parseDate = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(Duration(days: dayFromNow)));
    print(parseDate);
    return listWeather
        .where((element) => element.dateTime.contains(parseDate))
        .toList();
  }

  void setSelectedDay(int value) {
    indexSelected = value;
    selectedWeatherModel = listDayWeathers()[value];
    notifyListeners();
  }

  void setSelectedDate(int value) {
    indexSelectedDate = value;
    selectedWeatherModel = listDayWeathers(dayFromNow: value)[0];
    notifyListeners();
  }
}
