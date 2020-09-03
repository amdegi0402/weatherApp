import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

//現在の日付
String date(int add) {
  //add 加算する日数　1-2-4-7-11-15-20
  initializeDateFormatting('ja');
  //var format = new DateFormat.yMMMd('ja');
  var month_now = new DateFormat.M().format(DateTime.now()); //現在の月
  var day_now = new DateFormat.d().format(DateTime.now()); //現在の日付
  var days;
  var monthes;

  //文字型を整数型へ変換
  try {
    days = int.parse(day_now.toString());
  } catch (exception) {
    days = 0;
  }
  try {
    monthes = int.parse(month_now.toString());
  } catch (exception) {
    monthes = 0;
  }
  var add_days = days + add;
  //print("month_now=$month_now");
  //print("add_days=$add_days");

  switch (month_now.toString()) {
    case "1": //31
      {
        if (add_days > 31) {
          monthes += 1;
          add_days -= 31;
        }
        String result = monthes.toString() + "/" + add_days.toString();
        return result;
      }
    case "2": //28
      {
        if (add_days > 28) {
          monthes += 1;
          add_days -= 28;
        }
        String result = monthes.toString() + "/" + add_days.toString();
        return result;
      }
    case "3": //31
      {
        if (add_days > 31) {
          monthes += 1;
          add_days -= 31;
        }
        String result = monthes.toString() + "/" + add_days.toString();
        return result;
      }
    case "4": //30
      {
        if (add_days > 30) {
          monthes += 1;
          add_days -= 30;
        }
        String result = monthes.toString() + "/" + add_days.toString();
        return result;
      }
    case "5": //31
      {
        if (add_days > 31) {
          monthes += 1;
          add_days -= 31;
        }
        String result = monthes.toString() + "/" + add_days.toString();
        return result;
      }
    case "6": //30
      {
        if (add_days > 30) {
          monthes += 1;
          add_days -= 30;
        }
        String result = monthes.toString() + "/" + add_days.toString();
        return result;
      }
    case "7": //31
      {
        if (add_days > 31) {
          monthes += 1;
          add_days -= 31;
        }
        String result = monthes.toString() + "/" + add_days.toString();
        return result;
      }
    case "8": //31
      {
        if (add_days > 31) {
          monthes += 1;
          add_days -= 31;
        }
        String result = monthes.toString() + "/" + add_days.toString();
        return result;
      }
    case "9": //31
      {
        if (add_days > 30) {
          monthes += 1;
          add_days -= 30;
        }
        String result = monthes.toString() + "/" + add_days.toString();
        return result;
      }
    case "10": //31
      {
        if (add_days > 31) {
          monthes += 1;
          add_days -= 31;
        }
        String result = monthes.toString() + "/" + add_days.toString();
        return result;
      }
    case "11": //30
      {
        if (add_days > 30) {
          monthes += 1;
          add_days -= 30;
        }
        String result = monthes.toString() + "/" + add_days.toString();
        return result;
      }
    case "12": //31
      {
        if (add_days > 31) {
          monthes = 1;
          add_days -= 31;
        }
        String result = monthes.toString() + "/" + add_days.toString();
        return result;
      }
  }
}
//文字型を整数型へ変換する処理
changeToInt(String str) {
  int value;
  try {
    value = int.parse(str.toString());
  } catch (exception) {
    value = 0;
  }
  return value;
}
