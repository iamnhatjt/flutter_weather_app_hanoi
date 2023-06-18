import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_company/provider/weather_provider.dart';
import 'package:test_company/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context) {
          return context.watch<WeatherProvider>().isGoodApi
              ? const MyHomePage()
              : const CircularProgressIndicator();
        }),
      ),
    );
  }
}
