import 'package:flutter/material.dart';
import 'dart:async';
import '../top_page/weather_main.dart';
import '../database/databases.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
//import '../Widgets/Weather.dart';

//選択された県ナンバーからデータベースの山名を取得 引数１:県ナンバー 引数２:山名or標高のどちらの値を返すかを知らせるためのナンバー
Future readMountName(int nums, int nums2) async{
  List<String> data = [];
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db');
  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
  //選択された県ナンバーから山名リストを取得
  var value = await database.rawQuery('SELECT name FROM MyData WHERE grp=$nums');
  //選択された県ナンバーから標高リストを取得
  var evalue = await database.rawQuery('SELECT elevation FROM MyData WHERE grp=$nums');
  //listから山名だけ取り出して変数に挿入
  if(nums2 == 0){
    for(var i=0; i<value.length; i++){
      data.add(value[i]["name"].toString());
    }
  }else{
    //listから標高だけ取り出して変数に挿入
    for(var i=0; i<evalue.length; i++){
      data.add(evalue[i]["elevation"].toInt().toString());
    }
  }
  return data;//山名と標高が入ったデータリストを返す
}

class MountainList extends StatefulWidget{
  final String title ="山を選択してください";
  final int num;
  //MountainList({Key key, this.title}) : super(key: key);
  MountainList({this.num});//main.dartから取得した県ナンバーをセット
    
  @override
  _MountainListState createState(){
    return  _MountainListState(nums: num);//引数に県ナンバーを挿入して_MountainListStateへ渡す
  }
}

class _MountainListState extends State<MountainList>{
  final int nums;
  List<String> nameData =[];
  List<String> elevationData =[];
  _MountainListState({this.nums});//取得した県ナンバーをセット

  @override
  initState() { 
    super.initState();
    //createDatabase();
    var result = readMountName(nums,0);
    var result2 = readMountName(nums,1);
    //result.then((var datas) => nameData = datas);
    //result2.then((var datas2) => setState((){elevationData = datas2;}));
    result.then((var ndatas) => result2.then((var edatas) => setState((){nameData=ndatas; elevationData=edatas;})));
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(//ListView.separatedでリストに区切り線を表示する
        itemCount: nameData.length,
        separatorBuilder: (BuildContext context, int index)=> Divider(color: Colors.black,),
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: ListTile(
              leading: Icon(Icons.filter_hdr),
              title: Text(nameData[index]),
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyWeather(catchName: nameData[index]), 
                    //builder: (context) => MyWeather(catchNum: nums), //次のページへ　MyWeatherクラスが呼び出される
                  ),
                );
              },
              subtitle: Text("標高 ${elevationData[index]} m"),
            ),
          ); 
        }
      ),
    );
  }
}