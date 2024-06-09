class WeatherModel {
  final String ikon;
  final String durum;
  final String derece;
  final String min;
  final String max;
  final String gece;
  final String nem;
  final String gun;
  final String havaDurum;

  WeatherModel(this.ikon, this.durum, this.derece, this.min, this.max,
      this.gece, this.nem, this.gun, this.havaDurum);

  WeatherModel.fromJSON(Map<String, dynamic> json)
      : ikon = json['icon'],
        durum = json['status'],
        derece = json['degree'],
        min = json['min'],
        max = json['max'],
        gece = json['night'],
        nem = json['humidity'],
        gun = json['day'],
        havaDurum = json['description'];
}
