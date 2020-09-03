import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../database/databases.dart';
import 'package:path/path.dart';
import '../top_page/weather_main.dart';

class Favorites extends StatefulWidget{
  final String title ="お気に入り";

  @override
  _FavoritesState createState(){
    return  _FavoritesState();//引数に県ナンバーを挿入して_MountainListStateへ渡す
  }
}
class _FavoritesState extends State<Favorites>{
     bool favorite;
     //bool favorite2;
     //bool favorite3;
    var nameData;
   
    @override
    initState() { 
      super.initState();
      var result = readFavorite();
      result.then((var nd) => setState((){nameData = nd;}));
    }
  
    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text("お気に入り登録一覧"),
        ),
        
        body: Center(
        
        child:ListView.separated(//ListView.separatedでリストに区切り線を表示する
        itemCount: nameData.length,
        separatorBuilder: (BuildContext context, int index)=> Divider(color: Colors.black,),
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: ListTile(
              leading: Icon(Icons.filter_hdr),
              title: Text(nameData[index]),
              /*
              trailing: Icon(
                  favorite == true ? Icons.favorite_border : Icons.favorite,
                  color: favorite == true ? Colors.white : Colors.red,
              ),
             */
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyWeather(catchName: nameData[index]), //次のページへ　MyWeatherクラスが呼び出される
                  ),
                );
              },
            ),
            );
          }
        )
        )
      );
    }
    
          /*
          child:ListView(
          children: <Widget>[
            ListTile(
              //leading: Icon(Icons.map),
              title: Text('Map'),
              trailing: FlatButton(
                child: Icon(
                    favorite == true ? Icons.favorite : Icons.favorite_border,
                    color: favorite == true ? Colors.red : Colors.white,
                  ),
                onPressed: () {
                    setState(() {
                      if(favorite != true) {
                    //ハートが押されたときにfavoriteにtrueを代入している
                        favorite = true;
                      }else{
                        favorite = false;
                      }
                    });
                  },
                ),
            ),
            ListTile(
              title: Text('Map'),
              trailing: FlatButton(
                child: Icon(
                    favorite2 == true ? Icons.favorite : Icons.favorite_border,
                    color: favorite2 == true ? Colors.red : Colors.white,
                  ),
                onPressed: () {
                    setState(() {
                      if(favorite2 != true) {
                    //ハートが押されたときにfavoriteにtrueを代入している
                        favorite2 = true;
                      }else{
                        favorite2 = false;
                      }
                    });
                  },
                ),
            ),
            ListTile(
              title: Text('Map'),
              trailing: FlatButton(
                child: Icon(
                    favorite3 == true ? Icons.favorite : Icons.favorite_border,
                    color: favorite3 == true ? Colors.red : Colors.white,
                  ),
                onPressed: () {
                    setState(() {
                      if(favorite3 != true) {
                    //ハートが押されたときにfavoriteにtrueを代入している
                        favorite3 = true;
                      }else{
                        favorite3 = false;
                      }
                    });
                  },
                ),
            ),
          ],
        ),  */
          
     

  Future<List<String>> readFavorite() async{
    var favoriteNames = new List<String>();
    //databaseへ接続
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'my.db');
    var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);

    //指定のテーブルからお気に入りに登録している山名一覧を取得
    var value = await database.rawQuery('SELECT name FROM MyData WHERE favorite=1');
    
    for(var i=0; i < value.length; i++){
      favoriteNames.add(value[i]["name"].toString());
    }
    print(favoriteNames);
    return favoriteNames;
    //setState((){});
  }
}