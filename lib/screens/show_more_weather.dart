import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_company/core/constant_theme.dart';
import 'package:test_company/core/extention.dart';
import 'package:test_company/provider/weather_provider.dart';
import 'package:test_company/widgets/icon.dart';
import 'package:test_company/widgets/show_detail_day.dart';

import '../core/path_image.dart';
import '../widgets/show_main_weather.dart';

class ShowMoreWeather extends StatelessWidget {
  const ShowMoreWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                      colors: [Color(0xFF8bb7fe), Color(0xFF5997fd)])),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppbarWeather(),
                  listDate(),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0, -MediaQuery.of(context).size.height * 0.16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  showDetailWeather(),
                  const SizedBox(
                    height: 10,
                  ),
                  ...List.generate(
                      context
                          .watch<WeatherProvider>()
                          .listDayWeathers(
                              dayFromNow: context
                                  .watch<WeatherProvider>()
                                  .indexSelectedDate)
                          .length, (index) {
                    final weatherModel = context
                        .watch<WeatherProvider>()
                        .listDayWeathers(
                            dayFromNow: context
                                .watch<WeatherProvider>()
                                .indexSelectedDate)[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 30,
                                spreadRadius: 5,
                                offset: const Offset(2, 10))
                          ]),
                      child: Row(
                        children: [
                          Text(
                            weatherModel.dateTime.substring(11, 16),
                            style: const TextStyle(
                                color: Color(0xFF5e9afd),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                            child: Center(
                              child: (RichText(
                                text: TextSpan(
                                    text:
                                        '${weatherModel.tempMax.toInt() - 273}°',
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 30,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            '/ ${weatherModel.tempMin.toInt() - 273}°',
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ]),
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  weatherModel.description.toPathImage(),
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  weatherModel.main,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Color(0xFF5e9afd),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  ShowMainWeather showDetailWeather() {
    return ShowMainWeather(
      child: const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: RowMainWeather(),
      ),
    );
  }

  Widget listDate() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            context.read<WeatherProvider>().setSelectedDate(index);
          },
          child: ShowBriefDate(
            model: context
                .watch<WeatherProvider>()
                .listDayWeathers(dayFromNow: index)[0],
            isSelected:
                context.watch<WeatherProvider>().indexSelectedDate == index,
            dateTime: DateTime.now().add(
              Duration(days: index),
            ),
          ),
        ),
      ),
    );
  }
}

class AppbarWeather extends StatelessWidget {
  const AppbarWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: WhiteIcon(icon: Icons.arrow_back_ios_outlined),
        ),
      ),
      title: Text(
        'Next 7 days',
        style: AppText.f16W5.copyWith(color: Colors.white, fontSize: 20),
      ),
      actions: [
        Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 50,
              spreadRadius: 1,
              offset: Offset(0, -1),
              color: Colors.black12,
            ),
          ]),
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                PathImage.logo,
                fit: BoxFit.cover,
              )),
        )
      ],
    );
  }
}
