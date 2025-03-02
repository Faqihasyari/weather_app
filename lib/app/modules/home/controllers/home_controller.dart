import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../../services/weather_services.dart';

class HomeController extends GetxController {
  final WeatherServices weatherService = WeatherServices();

  var currentWeather = {}.obs;
  var forecastWeather = {}.obs;
  var isLoading = true.obs;

  /// ✅ Ambil lokasi pengguna
  Future<Position> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 🔹 Cek apakah layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Layanan lokasi tidak aktif");
    }

    // 🔹 Cek izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Izin lokasi ditolak");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Izin lokasi ditolak secara permanen");
    }

    // 🔹 Ambil lokasi pengguna
    return await Geolocator.getCurrentPosition();
  }

  /// ✅ Ambil data cuaca berdasarkan lokasi
  Future<void> fetchWeatherByLocation() async {
    try {
      isLoading(true);
      Position position = await getUserLocation();
      var current = await weatherService
          .getCurrentWeather("${position.latitude},${position.longitude}");
      var forecast = await weatherService.getForecastWeather(
          "${position.latitude},${position.longitude}", 5);
      currentWeather.value = current;
      forecastWeather.value = forecast;
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data cuaca');
    } finally {
      isLoading(false);
    }
  }

  String getWeatherIcon(double temp, String condition) {
    if (condition.contains("Rain")) {
      return 'assets/rainy.png';
    } else if (condition.contains("Cloud")) {
      return 'assets/cloudy.png';
    } else if (temp > 30) {
      return 'assets/sunny.png';
    } else {
      return 'assets/storm.png';
    }
  }

  String getWeatherStatus(double temp, String text) {
    if (temp >= 30) {
      return 'Clear';
    } else if (temp >= 28) {
      return 'Partly Cloudy';
    } else if (temp >= 24) {
      return 'Mostly Cloudy ';
    } else if (temp >= 21) {
      return 'Rainy';
    } else {
      return 'Storming';
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchWeatherByLocation(); // Ambil cuaca berdasarkan lokasi
  }
}
