import 'package:get/get.dart';

class DraggableController extends GetxController {
  // Variabel untuk menyimpan posisi atas dari container
  var topPosition = 300.0.obs; // obs agar bisa digunakan dengan Obx

  // Fungsi untuk memperbarui posisi saat digeser
  void updatePosition(double dy, double maxHeight) {
    topPosition.value += dy;

    // Batasi pergerakan agar tidak keluar dari batas layar
    if (topPosition.value < 100) {
      topPosition.value = 100; // Batas atas
    }
    if (topPosition.value > maxHeight - 100) {
      topPosition.value = maxHeight - 100; // Batas bawah
    }
  }
}
