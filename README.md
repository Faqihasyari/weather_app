# 🌤️ Weather App – Flutter + GetX + WeatherAPI

Aplikasi cuaca berbasis **Flutter** yang menggunakan **WeatherAPI.com** untuk menampilkan cuaca real-time, prediksi cuaca harian, dan prediksi cuaca per jam. Aplikasi ini juga memanfaatkan **GetX** sebagai state management sehingga responsif dan mudah dikembangkan.

---

## ✨ Fitur Utama

### **1. Cuaca Saat Ini**
- Menampilkan suhu real-time (`current.temp_c`)
- Menampilkan kondisi cuaca & icon
- Data diambil langsung dari WeatherAPI

### **2. Prediksi Cuaca per Jam (Hourly Forecast)**
- Menggunakan `forecast.forecastday[0].hour`
- Menampilkan 24 jam ke depan dalam bentuk card horizontal

### **3. Prediksi Cuaca 3 Hari**
- WeatherAPI menyediakan maksimal 3 hari (`days=3`)
- Day 0 → hari saat ini  
- Day 1 → besok  
- Day 2 → lusa  
- Menampilkan:
  - Suhu max/min
  - Kondisi
  - Icon cuaca

### **4. Dynamic Background**
Background berubah otomatis tergantung kondisi cuaca:
- Cerah → background terang  
- Mendung / hujan → background gelap / biru keabu-abuan  

---

## ❗ Kenapa suhu utama berbeda dengan suhu di prediksi pertama?

Perbedaan ini **normal** karena:

- **`current.temp_c`** = suhu real-time saat ini  
- **Hourly forecast** memberikan data **per jam**, tetapi **tidak menampilkan jam yang sudah lewat**

Contoh:  
Sekarang jam 02:13 → WeatherAPI hanya memberikan data mulai jam 03:00  
→ suhu jam 03:00 bisa 21.5°C meski suhu saat ini 16.2°C

Ini bukan error aplikasi — memang begitu cara kerja WeatherAPI.

---

## 🛠️ Teknologi yang Digunakan

| Teknologi | Fungsi |
|----------|--------|
| Flutter | UI & logic aplikasi |
| GetX | State management |
| http | Fetch API |
| WeatherAPI.com | Sumber data cuaca |
| Google Fonts | Styling font |

