weatherIcon(String weatherText){
  String weatherIcon;

  switch (weatherText) {
      case "雷雨":
        weatherIcon = "sanderrain.png";    
        return weatherIcon;
      case "雷雨（強）":
        weatherIcon = "sanderrain.png";    
        return weatherIcon;
      case "晴れ":
        weatherIcon = "sun.png";    
        return weatherIcon;
      case "雨":
        weatherIcon = "rain.png";    
        return weatherIcon;
      case "雨（強）":
        weatherIcon = "rain.png";    
        return weatherIcon;
      case "曇り":
        weatherIcon = "cloud.png";    
        return weatherIcon;
      case "霧雨":
        weatherIcon = "mistrain.png";    
        return weatherIcon;
      case "霧雨（強）":
        weatherIcon = "mistrain.png";    
        return weatherIcon;
      case "霧":
        weatherIcon = "mist.png";    
        return weatherIcon;
      case "竜巻":
        weatherIcon = "tatumaki.png";    
        return weatherIcon;
      case "雪":
        weatherIcon = "snow.png";    
        return weatherIcon;
      case "雪（強）":
        weatherIcon = "snow.png";    
        return weatherIcon;
      case "砂ほこり":
        weatherIcon = "smork.png";    
        return weatherIcon;
      case "煙":
        weatherIcon = "smork.png";    
        return weatherIcon;
      case "晴れ時々曇り":
        weatherIcon = "harekumori.png";    
        return weatherIcon;
      case "曇り時々晴れ":
        weatherIcon = "kumorihare.png";    
        return weatherIcon;
  }
}