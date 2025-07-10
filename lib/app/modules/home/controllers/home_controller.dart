import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../../services/weather_services.dart';

class HomeController extends GetxController {
  final WeatherServices weatherService = WeatherServices();

  var currentWeather = {}.obs;
  var forecastWeather = {}.obs;
  var isLoading = true.obs;
  var topPosition = (Get.width * 1.6 / 2).obs;

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

  /// ✅ Ambil prakiraan cuaca beberapa hari ke depan berdasarkan lokasi
  Future<void> fetchForecastWeatherByLocation(int days) async {
    try {
      isLoading(true);
      Position position = await getUserLocation();
      var forecast = await weatherService.getForecastWeather(
          "${position.latitude},${position.longitude}", days);
      forecastWeather.value = forecast;
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data prakiraan cuaca');
    } finally {
      isLoading(false);
    }
  }

  String getWeatherIcon(double temp, String condition) {
    if (temp > 30) {
      return 'assets/sunny.png';
    } else if (temp >= 25) {
      return 'assets/cloudy.png';
    } else if (temp >= 20) {
      return 'assets/rainy.png';
    } else {
      return 'assets/storm.png';
    }
  }

  String getWeatherStatus(double temp, String text) {
    if (temp > 30) {
      return 'Clear';
    } else if (temp >= 28) {
      return 'Partly Cloudy';
    } else if (temp >= 24) {
      return 'Cloudy';
    } else if (temp >= 20) {
      return 'Rainy';
    } else {
      return 'Storming';
    }
  }

  void toggleSheet() {
    if (topPosition.value == Get.width * 1.3 / 2) {
      // Turunkan container, sisakan 1/4 bagian
      topPosition.value = Get.height * 0.650;
    } else {
      // Naikkan kembali
      topPosition.value = Get.width * 1.3 / 2;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchWeatherByLocation(); // Ambil cuaca berdasarkan lokasi
    fetchForecastWeatherByLocation(5);
  }
}
