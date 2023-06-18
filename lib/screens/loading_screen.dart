import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_company/core/path_image.dart';

import '../provider/weather_provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (!context.watch<WeatherProvider>().isGoodApi) {
        onReload();
      }
    });
  }

  void onReload() {
    setState(() {
      isLoading = true;
    });
    WeatherProvider();
    Future.delayed(
      const Duration(seconds: 5),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                PathImage.iconWeatherNormal,
                height: 300,
                width: 300,
                fit: BoxFit.contain,
              ),
              isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.amber,
                    )
                  : ElevatedButton(
                      onPressed: () {
                        onReload();
                      },
                      child: const Text('Try again'),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
