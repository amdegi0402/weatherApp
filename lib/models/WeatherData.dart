//import '../models/MountNameData.dart';

class WeatherData {
  final DateTime date;
  final String name;
  final double temp;
  final String main;
  final String icon;
  //追加分
  //final double wind;
  final double speed;
  double elevation;
  final mainId;
  String custom_name;//山名（日本語表記）
 
  WeatherData({this.date, this.name, this.temp, this.main, this.icon, this.speed, this.elevation, this.mainId, this.custom_name});
  
  

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    
    return WeatherData(
      //print("name=${WeatherData().name}"),
      date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      name: json['name'],
      //name: WeatherData().name,
      temp: json['main']['temp'].toDouble(),
      main: json['weather'][0]['main'],
      mainId: json['weather'][0]['id'].toString(),
      icon: json['weather'][0]['icon'],
      speed: json['wind']['speed'].toDouble(),//風速
      //wind: json['wind']['deg'],//風向き
      custom_name: WeatherData().custom_name,//山名日本語表記
      elevation: WeatherData().elevation,//標高
    );
  }
}