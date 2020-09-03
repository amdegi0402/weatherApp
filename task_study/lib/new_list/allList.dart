import 'package:flutter/material.dart';
import '../sqlite.dart';
import '../drawerMenu.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'edit/edit.dart';

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Baby Names",
      home: AllList(),
    );
  }
}

class AllList extends StatefulWidget {
  @override
  _AllListState createState() => _AllListState();
}

class _AllListState extends State<AllList> {
  List<String> title = [];
  List<String> day = [];
  List<String> level = [];
  List<String> next_day = [];
  List<String> id = [];


  @override
  initState() {
    super.initState();
    //createDatabase();
    var result_1 = readStudyDays(2); //タイトル読み込み
    var result_2 = readStudyDays(3); //登録日読み込み
    var result_3 = readStudyDays(4); //レベル読み込み
    var result_4 = readStudyDays(6); //次の学習日読み込み
    var result_5 = readStudyDays(7); //ID読み込み
    result_1.then((var ndatas) => result_2.then((var ndatas_2) => result_3.then(
        (var ndatas_3) => result_4.then(
            (var ndatas_4) => result_5.then((var ndatas_5) => setState(() {
                  title = ndatas;
                  day = ndatas_2;
                  level = ndatas_3;
                  next_day = ndatas_4;
                  id = ndatas_5;
                }))))));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar.builder(
      itemCount: title.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            //リストの区切り線
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38),
              ),
            ),
            child: Dismissible(
              //スワイプでリストを削除する処理
              key: Key(title[index]),
              child: ListTile(
                  leading: Icon(Icons.event_available),
                  title: Text("記憶Lv${level[index]}  " + title[index]),
                  subtitle: Text("${day[index]}に登録  NEXT ${next_day[index]}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditList(
                            catch_id: id[
                                index]), //次のページへ　科目名,キーワード,idを渡す処理　EditListクラスが呼び出される edit.dart
                        //builder: (context) => MyStatefullWidget(),
                      ),
                    );
                  }),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                //データベースからリストを削除
                // 削除アニメーションが完了し、リサイズが終了したときに呼ばれる

                setState(() {
                  deleteDb(title[index]);
                  title.removeWhere((t) => t == title[index]);
                });
              },
            ));
      },
      drawer: Drawer(
        child: drawerMenu(context),
      ),
      onChanged: (String value) async {
        var result = await searchStr(value);
        setState(() {
          title = result;
        });
      },
      onTap: () {},
      decoration: InputDecoration.collapsed(
        hintText: "ここに入力して検索...",
      ),
    );

    bool searcStr(String title, String searchWord) {
      bool juge;
      juge = title
          .startsWith(searchWord); //検索文字(searchWord)がタイトルにあればtrue,そうでなければfalse
      return juge;
    }
  }
}
