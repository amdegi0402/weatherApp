import 'package:flutter/material.dart';
import 'package:grafic/database/databases.dart';
import 'package:grafic/top_page/MoutainList.dart';

void main() => runApp(new MyApp());
var width;


class MyApp extends StatelessWidget {
  var size = 20.0;
    
  @override
  Widget build(BuildContext context){ 
    createDatabase();
    return MaterialApp(
      title: 'top page',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightGreen[800],
        accentColor: Colors.greenAccent[600],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('場所を選択してください'),
          centerTitle: true,
        ),
        body:LayoutBuilder(
          builder: (context, constraints) {
            //createDatabase();
            //スクロール
            return SingleChildScrollView(
          //県別のボタン設置
          child:
          Column(children: <Widget>[
            Padding(padding: EdgeInsets.all(10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Expanded(child: 
                ButtonTheme(
                  //minWidth: 155.0,
                  height: 150.0,
                  child: RaisedButton(
                    color: Colors.lightBlue[300],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //settings: RouteSettings(name: "/rooms/<roomId>"),
                          builder: (BuildContext context) => MountainList(num: 1)),//引数に県ナンバーを挿入して値を渡す
                      );
                    },
                    child: Text("福岡",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)),
                    shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                  ),
                ),
              ),

              Expanded(child:
                ButtonTheme(
                  //minWidth: 155.0,
                  height: 150.0,
                  child: RaisedButton(
                    color: Colors.red[100],
                   
                    onPressed:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //settings: RouteSettings(name: "/rooms/<roomId>"),
                          builder: (BuildContext context) => MountainList(num: 7)),
                      );
                    },
                    child: Text("大分",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)),
                    shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                  ),
                ),
              ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child:
                  ButtonTheme(
                    //minWidth: 155.0,
                    height: 150.0,
                    child: RaisedButton(
                      color: Colors.lightGreen[600],
                      onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //settings: RouteSettings(name: "/rooms/<roomId>"),
                          builder: (BuildContext context) => MountainList(num: 3)),
                      );
                    },
                      child: Text("長崎",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)),
                      shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                    ),
                  ),
                ),
                
                Expanded(child:
                  ButtonTheme(
                    //minWidth: 155.0,
                    height: 150.0,
                    child: RaisedButton(
                      color: Colors.blue[300],
                      onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //settings: RouteSettings(name: "/rooms/<roomId>"),
                          builder: (BuildContext context) => MountainList(num: 2)),//引数に県ナンバーを挿入して値を渡す
                      );
                    },
                      child: Text("佐賀",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)),
                      shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child:
                  ButtonTheme(
                    //minWidth: 155.0,
                    height: 150.0,
                    child: RaisedButton(
                      color: Colors.red[300],
                      onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //settings: RouteSettings(name: "/rooms/<roomId>"),
                          builder: (BuildContext context) => MountainList(num: 4)),//引数に県ナンバーを挿入して値を渡す
                      );
                    },
                      child: Text("熊本",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)),
                      shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                    ),
                  ),
                ),

                Expanded(child:
                  ButtonTheme(
                    //minWidth: 155.0,
                    height: 150.0,
                    child: RaisedButton(
                      color: Colors.green,
                      onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //settings: RouteSettings(name: "/rooms/<roomId>"),
                          builder: (BuildContext context) => MountainList(num: 5)),//引数に県ナンバーを挿入して値を渡す
                      );
                    },
                      child: Text("宮崎",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)),
                      shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child:
                  ButtonTheme(
                    //minWidth: 155.0,
                    height: 150.0,
                    child: RaisedButton(
                      color: Colors.black38,
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          //settings: RouteSettings(name: "/rooms/<roomId>"),
                          builder: (BuildContext context) => MountainList(num: 6)),//引数に県ナンバーを挿入して値を渡す
                      );},
                      child: Text("鹿児島",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)),
                      shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                    ),
                  ),
                ),

                Expanded(child:
                  ButtonTheme(
                    //minWidth: 155.0,
                    height: 150.0,
                    child: RaisedButton(
                      color: Colors.pink[300],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //settings: RouteSettings(name: "/rooms/<roomId>"),
                            builder: (BuildContext context) => MountainList(num: 8)),//引数に県ナンバーを挿入して値を渡す
                        );
                      },
                      child: Text("沖縄",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)),
                      shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                    ),
                  ),
                ),
              ],
            ), 
          ],)
        );
          }
          
      )
    )
    );
  }
}




 

 

