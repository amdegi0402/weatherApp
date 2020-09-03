import 'package:flutter/material.dart';
import 'package:grafic/models/WeatherIcons.dart';
import 'package:intl/intl.dart';
import '../models/WeatherData.dart';
import '../models/ChangeWeather.dart';
import '../database/databases.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


//画面に表示する内容　メイン
class Weather extends StatelessWidget{
  final WeatherData weather;
  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context ){
    
    //String selevation;//標高
    //String name = test.toString();
    //String name = changeName(weather.name);
    var formatter = new DateFormat("M/dd ");//時間フォーマット
    //var formatted = formatter.format(datetime); // DateからString
    var main = changeWeather(weather.mainId);//天気予報を日本語表示に変換する処理
    String iconName = weatherIcon(main);//日本語表示の天気予報からアイコンファイル名を返す処理
    //selevation = returnElevation(name).toInt().toString();//山名から標高を返す（文字型へ変換）
    AssetImage assetImage = AssetImage("assets/${iconName}");  //メインアイコンの挿入
    var ondosa = (weather.elevation / 100.0 * 0.4).toInt();//山頂と地上の気温差を計算
    var topsTemp = weather.temp - ondosa;//山頂付近の気温を計算
    
    Widget mains;//天気情報によって文字表示色を変える処理
    if(main == "晴れ" || main == "曇り" || main == "晴れ時々曇り" || main == "曇り時々晴れ"){
      mains = Text(main, style: TextStyle(color: Colors.white, fontSize: 45.0, fontWeight: FontWeight.bold,));
    }else{
      mains = Text(main, style: TextStyle(color: Colors.grey, fontSize: 45.0, fontWeight: FontWeight.bold,));
    }

    
    
  
    
    return Column(
      children: <Widget>[
        Text('${formatter.format(weather.date)} 現在の天気', style: TextStyle(color: Colors.white,fontSize: 20.0)),//日付
        //Text(weather.name, style: TextStyle(color: Colors.white, fontSize: 30.0)),//山名 original
        //Text(weather.custom_name, style: TextStyle(color: Colors.white, fontSize: 20.0)),//山名 original
        //Text(main, style: TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold,)),//天気メッセージ
        mains,//天気メッセージ(表示色変更後)
        Image(image: assetImage, height: 120.0,),//アイコン
        Text('標高 ${weather.elevation.toInt().toString()}m', style: TextStyle(color: Colors.white, fontSize: 18.0)),//標高
        //Text(weather.main, style: TextStyle(color: Colors.white, fontSize: 25.0)),//天気メッセージ
        //Text(weather.main2.toString(), style: TextStyle(color: Colors.white, fontSize: 25.0)),//天気メッセージ
        Text('気温 ${weather.temp.toInt().toString()}℃', style: TextStyle(color: Colors.white,fontSize: 18.0)),//山頂付近の気温
        Text('山頂付近の気温 ${topsTemp.toInt().toString()}℃', style: TextStyle(color: Colors.white,fontSize: 18.0)),//山頂付近の気温
        Text('風速 ${weather.speed.toInt().toString()}m/s', style: TextStyle(color: Colors.white,fontSize: 18.0)),//風速
        //Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),//アイコン
       // Text(DateFormat.yMMMd().format(weather.date), style: TextStyle(color: Colors.white)),//日付
        
        //Text(DateFormat.Hm().format(weather.date), style: TextStyle(color: Colors.white,fontSize: 20.0)),//時刻
        //Text('標高 ${weather.elevation.toString()}m', style: TextStyle(color: Colors.white,)),//山頂付近の風速
        //Text('標高 ${elevation}m', style: TextStyle(color: Colors.white,)),//山頂付近の風速
      ],
    );
  }

  readElevation(String name) async{
      //databaseへ接続
      //print("r_id=$id");
      //id = id.toString();
      String databasesPath = await getDatabasesPath();
      String dbPath = join(databasesPath, 'my.db');
      var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
      //指定テーブルから特定idの標高を取得
      List<Map> targetElevation = await database.rawQuery('SELECT elevation FROM MyData WHERE name= "$name"');
      print("$targetElevation");
      //double型へ変換
      var dtargetElevation = await targetElevation[0]['elevation'].toDouble();
      print("6 $dtargetElevation"); 
  }
}