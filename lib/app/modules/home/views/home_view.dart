import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../../../../services/weather_services.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Color cnt = Color(0xff612FAB);
    Color fDays = Color(0xff48319D);
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
              //ambil cuaca dari lokasi
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
                            mainAxisSize: MainAxisSize.min,
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
                              Expanded(
                                child: Stack(children: [
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 100),
                                      child: Image.asset('assets/santa.png',
                                          height: Get.width * 0.8,
                                          width: Get.width * 0.8),
                                    ),
                                  ),
                                  //animasi container
                                  Obx(
                                    () => AnimatedPositioned(
                                      duration: Duration(milliseconds: 1000),
                                      top: controller.topPosition.value,
                                      left: 0,
                                      right: 0,
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 1000),
                                        height:
                                            controller.topPosition.value == 500
                                                ? 200
                                                : 200,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              cnt.withOpacity(0.5),
                                              Colors.transparent
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(50),
                                            topRight: Radius.circular(50),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            //toggle
                                            GestureDetector(
                                              onTap: () =>
                                                  controller.toggleSheet(),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Container(
                                                  width: 50,
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //Prediksi 5 hari kedepan
                                            Expanded(
                                              child: Obx(() {
                                                List<dynamic> forecastDays =
                                                    controller.forecastWeather[
                                                            'forecast']
                                                        ['forecastday'];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30),
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        forecastDays.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var day =
                                                          forecastDays[index];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SizedBox(
                                                          height:
                                                              Get.height * 0.1,
                                                          width:
                                                              Get.width * 0.2,
                                                          child: Card(
                                                            color: fDays
                                                                .withOpacity(
                                                                    0.3),
                                                            elevation: 8,
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        3),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            99)),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    cnt.withOpacity(
                                                                        0.8),
                                                                    Colors
                                                                        .purple
                                                                        .withOpacity(
                                                                            0.2),
                                                                  ],
                                                                  begin: Alignment
                                                                      .topCenter,
                                                                  end: Alignment
                                                                      .bottomCenter,
                                                                ),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            99)),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.3),
                                                                    blurRadius:
                                                                        2,
                                                                    spreadRadius:
                                                                        2,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            2),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        5.0),
                                                                child: Center(
                                                                  child: Column(
                                                                    spacing: 8,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat('EEE')
                                                                            .format(DateTime.parse(day['date']))
                                                                            .toUpperCase(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                      Image
                                                                          .asset(
                                                                        controller.getWeatherIcon(
                                                                            controller.currentWeather["current"]["temp_c"],
                                                                            controller.currentWeather["current"]["condition"]["text"]),
                                                                        width:
                                                                            20,
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      Text(
                                                                        "${day['day']['avgtemp_c']}°C",
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                      Text(
                                                                        controller.getWeatherStatus(
                                                                            controller.currentWeather["current"]["temp_c"],
                                                                            controller.currentWeather["current"]["condition"]["text"]),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              Get.size.height * 0.0150,
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              )
                            ],
                          )),
              ),
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