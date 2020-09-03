import 'package:flutter/material.dart';
import 'sqlite.dart';
import 'function/dateFunc.dart';
import 'function/dateFunc_2.dart';
import 'value.dart';
import 'drawerMenu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Baby Names",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController_1 = TextEditingController();
  final myController_2 = TextEditingController();
  List<String> title = [];
  List<String> keyword = [];
  List<String> id = [];

  @override
  initState() {
    super.initState();
    createDatabase();
    updateDb(date(0));
    var result_1 = readStudyDays(0, date(0)); //タイトル読み込み
    var result_2 = readStudyDays(1, date(0)); //キーワード読み込み
    var result_3 = readStudyDays(5, date(0)); //ID読み込み
    //var test = readStudyDays(8); //学習未完了があるタイトルを読み込み
    result_1.then((var ndatas) => result_2
        .then((var ndatas_2) => result_3.then((var ndatas_3) => setState(() {
              title = ndatas;
              keyword = ndatas_2;
              id = ndatas_3;
            }))));
  }
  

  @override
  Widget build(BuildContext context) {
    var val = calcDateNumber();
    var result = calcDate(val);
    return Scaffold(
      
      appBar: AppBar(title: Text("${date(0)}　反復学習リスト"), backgroundColor: Colors.pink.withOpacity(0.5)),
      drawer: Drawer(
        child: drawerMenu(context),
      ),
      body: Stack(
        children: <Widget>[
          new Container(
            height: double.infinity,
            width: double.infinity,
            decoration:new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
      listViewes(context, title, keyword, id),
        ]));
  }
}

Widget listViewes(BuildContext context, var title, var key, var id) {
  if (title == null) {
    print("titleはnull");
    return Center(child: Text("本日のタスクはありません"));
  } else {
    print("titleはnullではありません");
    return ListView.separated(
        //ListView.separatedでリストに区切り線を表示する
        itemCount: title.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.black,
            ),
        itemBuilder: (BuildContext context, int index) {
          
          return Card(
            
            child: ListTile(
                leading: Icon(Icons.grade),
                title: Text("${title[index]}"),
                subtitle: Text(key[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ValueList(catch_title: title[index],catch_key: key[index], catch_id: id[index]),//次のページへ　科目名,キーワード,idを渡す処理　ValueListクラスが呼び出される value.dart
                    ),
                  );
                }),
          );
        });
  }
}

