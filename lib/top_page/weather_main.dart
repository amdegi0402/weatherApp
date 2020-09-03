import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Widgets/Weather.dart';
import '../Widgets/WeatherItem.dart';
import '../models/WeatherData.dart';
import '../models/ForecastData.dart';
import '../database/databases.dart';
import '../main.dart';
import 'package:sqflite/sqflite.dart';
import '../top_page/favorite.dart';
import 'package:path/path.dart';
//import 'package:firebase_admob/firebase_admob.dart';
//import 'dart:io';

class MyWeather extends StatefulWidget {
  String catchName;//受取り変数
  
  MyWeather({this.catchName});//main.dartから山名を受け取る
  @override
  State<StatefulWidget> createState() {
    return new MyWeatherState(mountName: catchName);
  }
}

class MyWeatherState extends State<MyWeather> {
  int id;
  var _targetLon;
  var _targetLat;
  var _targetElevation;
  bool isLoading = false;
  WeatherData weatherData;
  WeatherData weatherData2;
  ForecastData forecastData;
  String error;
  String mountName;
  String _mountName;
  String fnum;
  MyWeatherState({this.mountName});
  Widget icons;

 
  @override
  void initState(){
    super.initState();   
    loadWeather();
    readFavoriteNum(mountName);
    //Admob.initialize(getAppId());//アプリID初期化
    /*
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-6617363713596381~3207481643").then((response){
      myBanner..load()..show();
      
    });
    */
    
   
  }
  
  @override
  Widget build(BuildContext context) {
    //int index = 0;

    return DefaultTabController(
      length:1,
      child: MaterialApp(
      title: '今日の天気',
      theme: ThemeData(
        //brightness: Brightness.dark,
        primaryColor: Colors.lightGreen[800],
        accentColor: Colors.greenAccent[600],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('$mountName の天気'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('ホーム'),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyApp(), //次のページへ　MyAppクラスが呼び出される
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('お気に入りリスト'),
                leading: Icon(Icons.favorite),
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Favorites(), //次のページへ　MyWeatherクラスが呼び出される
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            /*TabBarView(children: <Widget>[Favorites(),MountainList()],),*/
            
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/cloud1.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ), 
            
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: weatherData != null ? Weather(weather: weatherData) : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: isLoading ? CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: new AlwaysStoppedAnimation(Colors.white),
                          ) : IconButton(
                            icon: new Icon(Icons.refresh),
                            tooltip: 'Refresh',
                            onPressed: loadWeather,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom:50.0),
                      child: Container(
                        height: 160.0,
                        child: forecastData != null ? ListView.builder(
                            itemCount: forecastData.list.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => WeatherItem(weather: forecastData.list.elementAt(index))
                        ) : Container(),
                      ),
                    ),
                  ),
                ]
              )
            ), 
            checkFavorite(fnum, context, mountName), 
          ]  
        ),
        //FAB
      ),
    ),);
  }

  loadWeather() async {
    setState(() {
      isLoading = true;
    });
      _mountName = mountName;
      print("_mountName=$_mountName");
      await readLatLon(_mountName);//山名から情報取得
      print("_targetElevation=$_targetElevation");

      final lat = await _targetLat; //選択した山の緯度
      final lon = await _targetLon;//選択した山の経度
      final weatherResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/weather?APPID=852be680803b6db543797bdd89993cf3&units=metric&lat=${lat
              .toString()}&lon=${lon.toString()}');
      final forecastResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/forecast?APPID=852be680803b6db543797bdd89993cf3&units=metric&lat=${lat
              .toString()}&lon=${lon.toString()}');

      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          //テスト
          //メイン画面
          weatherData =
          WeatherData.fromJson(jsonDecode(weatherResponse.body));
          weatherData.custom_name = mountName;//山名日本語表記
          weatherData.elevation = _targetElevation;//標高
          //サブ画面
          forecastData =
          ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      }
    //}
    setState(() {
      isLoading = false;
    });
  }
  /*ここから関数*/
  //idから緯度経度を読み込み
  readLatLon(String mountNames) async{
      //databaseへ接続
      //print("r_id=$id");
      //id = id.toString();
      String databasesPath = await getDatabasesPath();
      String dbPath = join(databasesPath, 'my.db');
      var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
      //指定のテーブルから特定のidの経度緯度情報を取得
      List<Map> targetLon = await database.rawQuery('SELECT lon FROM MyData WHERE name= "$mountNames"');
      List<Map> targetLat = await database.rawQuery('SELECT lat FROM MyData WHERE name= "$mountNames"');
      //指定テーブルから特定idの標高を取得
      List<Map> targetElevation = await database.rawQuery('SELECT elevation FROM MyData WHERE name= "$mountNames"');
      print("$targetElevation");
      //double型へ変換
      double dtargetLon = await targetLon[0]['lon'].toDouble();
      double dtargetLat = await targetLat[0]['lat'].toDouble();
      double dtargetElevation = await targetElevation[0]['elevation'].toDouble();
  
      print("5 $dtargetLon");
      print("5 $dtargetLat");
      print("5 $dtargetElevation");
      //メインクラスの変数に緯度と経度をセット
      setState((){
        _targetLon = dtargetLon;
        _targetLat = dtargetLat;
        _targetElevation = dtargetElevation;
         
        //saveIt(dtargetElevation.toString());

      });
  }
  //データベースにアクセスしてお気に入りの登録があるかチェック　0か1を返す処理
  readFavoriteNum(String mountNames) async{
      //databaseへ接続
      String databasesPath = await getDatabasesPath();
      String dbPath = join(databasesPath, 'my.db');
      var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
      //指定のテーブルから特定のidの経度緯度情報を取得
      List<Map> targetLon = await database.rawQuery('SELECT favorite FROM MyData WHERE name= "$mountNames"');
     
      //double型へ変換
      String fnums = await targetLon[0]['favorite'].toString();
      //メインクラスの変数に緯度と経度をセット
      setState((){
        fnum = fnums;
        print("fnum=$fnum");
      });
  }

  //データベースへ接続してお気に入り登録・解除処理
  addFavorite(String fnum, String name) async{
      //databaseへ接続
      String databasesPath = await getDatabasesPath();
      String dbPath = join(databasesPath, 'my.db');
      var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
      //お気に入り追加:1or削除:0
      if(fnum == "0"){
        await database.rawInsert('UPDATE MyData SET favorite=1 WHERE name= "$name"');//お気に入り追加
        print("お気に入り追加");
        
      }else{
        await database.rawInsert('UPDATE MyData SET favorite=0 WHERE name= "$name"');//お気に入り削除
        print("お気に入り削除");
        setState((){fnum = "0";});
      }
  }

  //フロートボタンを表示=>お気に入り登録ありなしによってアラート表示
  Widget checkFavorite(String fnum, BuildContext context, String name) {
    //fnum:0 お気に入り登録なしの場合
    if (fnum == "0") {
      return FloatingActionButton(
          child: Icon(Icons.favorite_border),
          backgroundColor: Colors.pink,
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                content: Text("お気に入りに追加しました"),
                );
              },
            );
            addFavorite(fnum, name);
            setState((){readFavoriteNum(mountName);});
          },
          
        );
    //fnum:1 お気に入りに登録がある場合
    } else {
      return FloatingActionButton(
          onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
              content: Text("お気に入りから削除しました"),
              );
            }
          );
          addFavorite(fnum, name);
          setState((){readFavoriteNum(mountName);});
          },
          child: Icon(Icons.favorite),
          backgroundColor: Colors.pink,
        );
    }
  }
  
}
/*
MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  //adUnitId: BannerAd.testAdUnitId,
  adUnitId: "ca-app-pub-6617363713596381/7520478786",
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);
*/