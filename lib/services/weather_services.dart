import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  final String apiKey = '17fa1b61029c42c5961150609251007';
  final String baseUrl = 'https://api.weatherapi.com/v1';

  /// ✅ Mengambil cuaca saat ini berdasarkan nama kota
  Future<Map<String, dynamic>> getCurrentWeather(String city) async {
    final response = await http.get(
      Uri.parse('$baseUrl/current.json?key=$apiKey&q=$city'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil data cuaca');
    }
  }

  /// ✅ Mengambil prakiraan cuaca untuk beberapa hari ke depan
  Future<Map<String, dynamic>> getForecastWeather(String city, int days) async {
    final response = await http.get(
      Uri.parse(
          'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=$days'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil prakiraan cuaca');
    }
  }
}
