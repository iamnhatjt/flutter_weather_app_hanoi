import 'package:test_company/core/path_image.dart';

extension Expand on String {
  String toPathImage() {
    print(this);
    switch (this) {
      case 'Rain':
        return PathImage.iconRain;
      default:
        return PathImage.iconWeatherNormal;
    }
  }
}
