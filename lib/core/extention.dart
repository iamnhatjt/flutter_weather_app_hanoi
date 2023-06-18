import 'package:test_company/core/path_image.dart';

extension Expand on String {
  String toPathImage() {
    switch (this) {
      case 'Rain':
        return PathImage.iconRain;
      case 'light rain':
        return PathImage.iconLightRain;
      case 'moderate rain':
        return PathImage.iconModerate;
      case 'scattered clouds':
        return PathImage.iconScatterdClouds;
      case 'overcast clouds':
        return PathImage.iconOvercastClouds;

      default:
        return PathImage.iconWeatherNormal;
    }
  }
}
