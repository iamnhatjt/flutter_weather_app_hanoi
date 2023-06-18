import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_company/core/constant_theme.dart';
import 'package:test_company/provider/weather_provider.dart';
import 'package:test_company/screens/show_more_weather.dart';
import 'package:test_company/widgets/show_detail_day.dart';

import '../core/path_image.dart';
import '../widgets/icon.dart';
import '../widgets/show_main_weather.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: WhiteIcon(icon: CupertinoIcons.line_horizontal_3_decrease),
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const ShowLocation(),
              ShowMainWeather(),
              const RowMainWeather(),
              const RowMovePage(),
              Container(
                alignment: Alignment.center,
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      context.watch<WeatherProvider>().listDayWeathers().length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      context.read<WeatherProvider>().setSelectedDay(index);
                    },
                    child: ShowDetailDay(
                      isSelected:
                          context.watch<WeatherProvider>().indexSelected ==
                              index,
                      weatherModel: context
                          .watch<WeatherProvider>()
                          .listDayWeathers()[index],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RowMovePage extends StatelessWidget {
  const RowMovePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        children: [
          const Text(
            'Today',
            style: AppText.f32W6,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShowMoreWeather(),
                  ));
            },
            child: Text(
              'Next 7 Days',
              style: AppText.f16W5
                  .copyWith(color: const Color(0xFF5b98fd), fontSize: 18),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF5b98fd),
          )
        ],
      ),
    );
  }
}

class ShowLocation extends StatelessWidget {
  const ShowLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 35,
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'HANOI,',
                style: AppText.f32W6,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'VIETNAM',
                style: AppText.f32W6.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 16),
              Text(DateFormat('EEEEEE, dd MMM').format(DateTime.now()),
                  style: AppText.f16W5)
            ],
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 20,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                PathImage.hanoi,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),
          )
        ],
      ),
    );
  }
}
