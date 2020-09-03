import '../models/WeatherData.dart';

class ForecastData{
  final List list;
  final double elevation;
    
  


  ForecastData({this.list, this.elevation});

  factory ForecastData.fromJson(Map<String, dynamic> json){
    List list = List();
    

    for(dynamic e in json['list']){

      WeatherData w = WeatherData(
        date: new DateTime.fromMillisecondsSinceEpoch(e['dt'] * 1000, isUtc: false),
        name: json['city']['name'],
        temp: e['main']['temp'].toDouble(),
        main: e['weather'][0]['main'],
        icon: e['weather'][0]['icon'],
        speed: e['wind']['speed'].toDouble()
        
      );
      list.add(w);
      
    }

    return ForecastData(
      list: list,
    );
  }
}
