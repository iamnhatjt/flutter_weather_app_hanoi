import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_company/core/extention.dart';
import 'package:test_company/model/weather_model.dart';

class ShowDetailDay extends StatelessWidget {
  final bool isSelected;
  final WeatherModel weatherModel;
  const ShowDetailDay({
    super.key,
    required this.isSelected,
    required this.weatherModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 150,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
                colors: isSelected
                    ? [const Color(0xFFaea2ff), const Color(0xFF8270f8)]
                    : [Colors.white, Colors.white]),
            boxShadow: [
              BoxShadow(
                  color: isSelected ? const Color(0xFF8270f8) : Colors.black54,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(2, 2))
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              DateFormat('HH:mm')
                  .format(DateTime.parse(weatherModel.dateTime))
                  .toString(),
              style: TextStyle(
                  color: !isSelected ? Colors.black45 : Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Image.asset(
                weatherModel.description.toPathImage(),
                fit: BoxFit.contain,
                height: 40,
                width: 40,
              ),
            ),
            Text(
              '${weatherModel.temp.toInt() - 273}°',
              style: TextStyle(
                  color: !isSelected ? Colors.black45 : Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class ShowBriefDate extends StatelessWidget {
  final bool isSelected;
  final DateTime dateTime;
  final WeatherModel model;

  const ShowBriefDate(
      {super.key,
      required this.isSelected,
      required this.dateTime,
      required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: isSelected ? Colors.white : Colors.white.withOpacity(0.1),
      ),
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 5,
          ),
          Image.asset(
            model.description.toPathImage(),
            height: 30,
            width: 30,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            dateTime.day.toString(),
            style: TextStyle(
              color: isSelected ? const Color(0xFF8371f8) : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            DateFormat('EEE').format(dateTime),
            style: TextStyle(
              color: isSelected ? const Color(0xFF8371f8) : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
