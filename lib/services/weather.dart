import '../utilities/constants.dart';
import 'location.dart';
import 'networking.dart';

class WeatherModel {
  late double temp;
  late int weatherId;
  late String name;

  Future<void> getCurrentWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    Map<String, dynamic> weatherData = await NetworkHelper(
            url:
                "https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=$apiKey&units=metric")
        .getData();

    // if (mounted) {
    //   // if the object is in the tree run this code if not dont run
    //   Navigator.push(context, MaterialPageRoute(builder: (context) {
    //     return LocationScreen(position: location);
    //   }));
    // }
    temp = weatherData["main"]["temp"];
    weatherId = weatherData["weather"][0]["id"];
    name = weatherData["name"];
    print(temp);
  }

  Future<void> getCityWeather(String city) async {
    Location location = Location();
    Map<String, dynamic> cityData = await NetworkHelper(
            url:
                "https://api.openweathermap.org/geo/1.0/direct?q=$city&appid=$apiKey")
        .getcityData();
    location.lat = cityData["lat"];
    location.long = cityData["lon"];
    cityData = await NetworkHelper(
            url:
                "https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=$apiKey&units=metric")
        .getData();
    temp = cityData["main"]["temp"];
    weatherId = cityData["weather"][0]["id"];
    name = cityData["name"];
  }

  String getWeatherIcon() {
    if (weatherId < 300) {
      return '🌩';
    } else if (weatherId < 400) {
      return '🌧';
    } else if (weatherId < 600) {
      return '☔️';
    } else if (weatherId < 700) {
      return '☃️';
    } else if (weatherId < 800) {
      return '🌫';
    } else if (weatherId == 800) {
      return '☀️';
    } else if (weatherId <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage() {
    if (temp > 25) {
      return 'It\'s 🍦 time in $name';
    } else if (temp > 20) {
      return 'Time for shorts and 👕 in $name';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤 in $name';
    } else {
      return 'Bring a 🧥 just in case in $name';
    }
  }
}
