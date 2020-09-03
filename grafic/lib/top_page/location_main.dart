/*


class MyWeather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyWeatherState();
  }
}

class MyWeatherState extends State<MyWeather> {
  final _fname = 'hello.text';
  int id;
  String _textId;
  var targetLon;
  var targetLat;
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;
  Location _location = Location(); 
  String error;
 
  @override
  void initState() {
    super.initState();
    
    loadIt().then((String value){
      setState((){
        _textId = value;
        print("4 _text=$_textId");
        readLatLon(_textId);
      });
    });

    loadWeather();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Original Weather App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        backgroundColor: Colors.green[200],
        appBar: AppBar(
          title: Text('Original Weather App'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: weatherData != null ? Weather(weather: weatherData) : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200.0,
                    child: forecastData != null ? ListView.builder(
                        itemCount: forecastData.list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => WeatherItem(weather: forecastData.list.elementAt(index))
                    ) : Container(),
                  ),
                ),
              )
            ]
          )
        )
      ),
    );
  }

  loadWeather() async {
    setState(() {
      isLoading = true;
    });
    
    Map<String, double> location;

    try {
      location = await _location.getLocation(); //現在地取得

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    if (location != null) {
      
      final lat = targetLat; //選択した山の緯度
      final lon = targetLon;//選択した山の経度
      
      //readLatLon(id);

      final weatherResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/weather?APPID=852be680803b6db543797bdd89993cf3&lat=${lat
              .toString()}&lon=${lon.toString()}');
      final forecastResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/forecast?APPID=852be680803b6db543797bdd89993cf3&lat=${lat
              .toString()}&lon=${lon.toString()}');

      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          weatherData =
          WeatherData.fromJson(jsonDecode(weatherResponse.body));
          print("weatherData=$weatherData");
          forecastData =
          ForecastData.fromJson(jsonDecode(forecastResponse.body));
          print("forecastData=$forecastData");
          isLoading = false;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }
  //idから緯度経度を読み込み
  readLatLon(String id) async{
      //databaseへ接続
      //print("r_id=$id");
      //id = id.toString();
      String databasesPath = await getDatabasesPath();
      String dbPath = join(databasesPath, 'my.db');
      var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
      //指定のテーブルから特定のidの経度緯度情報を取得
      List<Map> _targetLon = await database.rawQuery('SELECT lon FROM MyData WHERE id= $id');
      List<Map> _targetLat = await database.rawQuery('SELECT lat FROM MyData WHERE id= $id');
      //print("$_targetLon  $targetLat");
      //double型へ変換
      double _dtargetLon = _targetLon[0]['lon'].toDouble();
      double _dtargetLat = _targetLat[0]['lat'].toDouble();
     
      print("5 $_dtargetLon");
      print("5 $_dtargetLat");
      //メインクラスの変数に緯度と経度をセット
      setState((){
        targetLon = _dtargetLon;
        targetLat = _dtargetLat;
      });
  }
   //ファイルアクセスの前に必要になるFileインスタンスを得るための処理
  Future<File> getDataFile(String filename) async{
    //割り当てられたフォルダパスの取得
    final directory = await getApplicationDocumentsDirectory();
    //ファイルパスの取得
    return File(directory.path + '/' + filename);
  } 
  //ファイルへテキスト保存処理
  void saveIt(String value) async{
    //getDataFileの呼び出し
    getDataFile(_fname).then((File file){
      //値の書き出し
      file.writeAsString(value);
    });
  }
  //テキスト読み込み処理
  Future<String> loadIt() async{
    await Future.delayed(Duration(seconds: 2));
    try{
      //getDataFileの呼び出し
      final file = await getDataFile(_fname);
      print("file= $file");
      //Future<String>を返す
      return file.readAsString();
    }catch(e){
      return null;
    }
  }

  //文字型を整数型へ変換して値を返す処理
  int changetoInt(String text){
    if(_textId == null){
      print("値がnullです");
      return 0;
    }else{
      //文字型から整数型への変換は例外を発生させる可能性があるため例外処理を書いておく
      try {
        id = int.parse(_textId.toString());
      } catch (exception) {
        id = 0;
      }
    }
    return id;
  }
  
}
*/