import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../../../../services/weather_services.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1482784160316-6eb046863ece?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: Get.height * 0.1,
                left: 0,
                bottom: 0,
                right: 0,
                child: Obx(() => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : controller.currentWeather.isEmpty
                        ? Text('Data tidak ada')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${controller.currentWeather["location"]["name"]}',
                                style: GoogleFonts.lexendMega(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${controller.currentWeather["current"]["temp_c"]}°',
                                    style: GoogleFonts.lexendMega(
                                        fontSize: 50, color: Colors.white),
                                  ),
                                  Image.asset(
                                    controller.getWeatherIcon(
                                        controller.currentWeather["current"]
                                            ["temp_c"],
                                        controller.currentWeather["current"]
                                            ["condition"]["text"]),
                                    width: 40,
                                    height: 40,
                                  ),
                                ],
                              ),
                              Text(
                                controller.getWeatherStatus(
                                    controller.currentWeather["current"]
                                            ["temp_c"]
                                        .toDouble(),
                                    controller.currentWeather["current"]
                                        ["condition"]["text"]),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }
}


//prediksi 5 hari kedepan 
// class HomeView extends GetView<HomeController> {
//   const HomeView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('HomeView'),
//         centerTitle: true,
//       ),
//       body: Center(child: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (controller.forecastWeather.isEmpty) {
//           return Center(child: Text("Data cuaca tidak tersedia"));
//         }

//         List<dynamic> forecastDays =
//             controller.forecastWeather['forecast']['forecastday'] ?? [];

//         return ListView.builder(
//           itemCount: forecastDays.length,
//           itemBuilder: (context, index) {
//             var day = forecastDays[index];

//             return Card(
//               child: ListTile(
//                 leading:
//                     Image.network("https:${day['day']['condition']['icon']}"),
//                 title: Text("${day['date']}"),
//                 subtitle: Text(
//                     "Suhu: ${day['day']['avgtemp_c']}°C, ${day['day']['condition']['text']}"),
//               ),
//             );
//           },
//         );
//       })),
//     );
//   }
// }


//suhu saat ini 
//class HomeView extends GetView<HomeController> {
//   const HomeView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('HomeView'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Obx(
//           () => controller.isLoading.value
//               ? const CircularProgressIndicator()
//               : controller.currentWeather.isEmpty
//                   ? const Text("Data cuaca tidak tersedia")
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Cuaca di ${controller.currentWeather["location"]["name"]}',
//                           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           'Suhu: ${controller.currentWeather["current"]["temp_c"]}°C',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         Text(
//                           'Suhu: ${controller.forecastWeather["current"]["temp_c"]}°C',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                       ],
//                     ),
//         ),
//       ),
//     );
    
//   }
// }