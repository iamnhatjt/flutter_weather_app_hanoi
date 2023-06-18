import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:test_company/core/path_image.dart';
import 'package:test_company/provider/weather_provider.dart';

import '../core/constant_theme.dart';
import '../core/extention.dart';

class ShowMainWeather extends StatelessWidget {
  Widget? child;
  ShowMainWeather({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final selectedWeather =
        context.watch<WeatherProvider>().selectedWeatherModel;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
          .copyWith(bottom: 0),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFadccfe),
              Color(0xFF5896fd),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFb0cefe),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.translate(
                offset: const Offset(0, -60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            spreadRadius: -1,
                            blurRadius: 50,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Image.asset(
                        selectedWeather.description.toPathImage(),
                        fit: BoxFit.contain,
                        height: 150,
                        width: 150,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      //change
                      selectedWeather.main,
                      style: AppText.f32W6.copyWith(color: Colors.white),
                    ),
                    Text(
                      //change
                      selectedWeather.description,
                      style: AppText.f16W5.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GradientText(
                    '${(selectedWeather.temp - 273).toInt()}°',
                    style: const TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.w600,
                    ),
                    colors: const [
                      Color(0xFFb5d1fe),
                      Color(0xFFf4f8ff),
                    ],
                  ),
                  Text(
                    'Feel Like ${selectedWeather.feelLike.toInt() - 273}°',
                    style: AppText.f16W5.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        PathImage.iconWave,
                        fit: BoxFit.contain,
                      ))
                ],
              )
            ],
          ),
          child ?? const SizedBox.shrink()
        ],
      ),
    );
  }
}

class RowMainWeather extends StatelessWidget {
  const RowMainWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedWeather =
        context.watch<WeatherProvider>().selectedWeatherModel;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        eachColumn(
            PathImage.iconHumidity, '${selectedWeather.humidity.toInt()} %'),
        eachColumn(PathImage.iconWindy,
            '${selectedWeather.windSpeed.toStringAsFixed(1)} m/s'),
        eachColumn(
            PathImage.iconpop, '${(selectedWeather.pop * 100).toInt()} %')
      ],
    );
  }

  Column eachColumn(String imagePath, String text) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.contain,
          height: 40,
          width: 40,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          text,
          style: const TextStyle(
              color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
