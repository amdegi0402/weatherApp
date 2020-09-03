import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/WeatherData.dart';
import 'dart:math' as Math;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../database/databases.dart';
import 'package:sqflite/sqflite.dart';





class WeatherItem extends StatelessWidget{
  final WeatherData weather;

  var _targetElevation;
  
  WeatherItem({Key key, @required this.weather}) : super(key: key);
  //WeatherItem({Key key, this.elevation, this.weather}) : super(key: key);
  //print(weather.main);
  
  @override
  Widget build(BuildContext context) {
   
    var formatter = new DateFormat("M月d日");//時間フォーマット
    var main = changeWeather(weather.main);//天気表示を日本語へ変換
    String iconName = WeatherItemIcon(main);//天気情報からアイコンファイル名を取得
    AssetImage assetImages = AssetImage("assets/${iconName}");  //メインアイコンの挿入
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[//サブ画面に表示するもの
          
            //Text(name, style: TextStyle(color: Colors.black, fontSize: 20)),//山名
            //Text(weather.main, style: TextStyle(color: Colors.black, fontSize: 25.0)),//英語天気メッセージ
            Text(main, style: TextStyle(color: Colors.black, fontSize: 25.0)),//日本語天気メッセージ
            Text('気温 ${weather.temp.toInt().toString()}℃', style: TextStyle(color: Colors.black)),//気温
            //Text('気温２ ${_temp.toString()}m/s', style: TextStyle(color: Colors.black)),//風速
            Text('風速 ${weather.speed.toInt().toString()}m/s', style: TextStyle(color: Colors.black)),//風速
            //Text('標高 ${_targetElevation.toString()}m', style: TextStyle(color: Colors.black)),
            //Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),//天気アイコン
            Image(image: assetImages, height: 30,),//アイコン
            Text(formatter.format(weather.date), style: TextStyle(color: Colors.black)),
            Text(DateFormat.Hm().format(weather.date), style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }

     //天気の表示を日本語表記に変換する処理
  changeWeather(String weather){
    String sweather;

    switch (weather) {
      case "Rain":
        sweather = "雨";    
        return sweather;
        //break;
      case "Clouds":
        sweather = "曇り";    
        return sweather;
        //break;
      case "Clear":
        sweather = "晴れ";    
        return sweather;
        //break;
    }
  }

      //天気の表示を日本語表記に変換する処理
  WeatherItemIcon(String weather){
    String name;

    switch (weather) {
      case "雨":
        name = "rain.png";    
        return name;
        //break;
      case "曇り":
        name = "cloud.png";    
        return name;
        //break;
      case "晴れ":
        name = "sun.png";    
        return name;
        //break;
    }
  }
  //山頂付近の風速を計算
  calcSpeed(double elevation, double speed){
    //基準風速 Vz = 求めたい風速 Vr (標高 Z / 基準の高さ Zr)^1/4
    var test =elevation / 10.0;
    var test2 = Math.pow(test, 0.25);
    var value = (speed * test2).toInt();

    print("風速=$value");
    return value;
    //return value; 
  }

  //山頂付近の温度を計算
  calcTemp(double elevation, double temp, double speed){
    //標高の値を100mで割る
    var ecnt =(elevation / 100);
    //値に0.6℃をかける
    var mtemp = 0.6 * ecnt;
    //地上の温度 - 標高差による温度調整
    var value = temp - mtemp;
    //気温が0℃以上の場合は風速1m/sで1℃気温が下がる
    if(value >= 0){
      value -= speed; 
    }else{
      //気温が0℃未満の場合は風速1m/sで2℃気温が下がる
      value -= speed * 2; 
    }

    //print("温度=$value");
    return value;
    //return value; 
  }

   //ファイルアクセスの前に必要になるFileインスタンスを得るための処理
  Future<File> getDataFile(String filename) async{
    //割り当てられたフォルダパスの取得
    final directory = await getApplicationDocumentsDirectory();
    //ファイルパスの取得
    return File(directory.path + '/' + filename);
  } 
 
  //テキスト読み込み処理
  Future<String> loadIt(String fname) async{
    await Future.delayed(Duration(seconds: 2));
    try{
      //getDataFileの呼び出し
      final file = await getDataFile(fname);
      print("file= $file");
      //Future<String>を返す
      return file.readAsString();
    }catch(e){
      return null;
    }
  }

  //read selから読み込み
  readDb(double temps, double speed) async{
      //databaseへ接続
      String databasesPath = await getDatabasesPath();
      String dbPath = join(databasesPath, 'my.db');
      var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
       //指定テーブルから
      List<Map> targetElevation = await database.rawQuery('SELECT elevation FROM MyData WHERE sel=1');
      print(targetElevation);
      //double型へ変換
      double dtargetElevation = await targetElevation[0]['elevation'].toDouble();
      //メインクラスの変数に緯度と経度をセット
       _targetElevation = dtargetElevation;
      print("dtargetElevation=$dtargetElevation");
      print("_targetElevation=$_targetElevation");


      //_temp = await calcTemp(dtargetElevation, temps, speed);
  }
}