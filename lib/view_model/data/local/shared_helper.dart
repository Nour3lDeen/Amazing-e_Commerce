import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper{
  static late final SharedPreferences _prefs ;
  static Future<void> init() async{
    _prefs= await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(String key,dynamic value) async {
    if(value is int){
      return await _prefs.setInt(key, value);
    }else if(value is String){
      return await _prefs.setString(key, value);
    }else if(value is bool){
      return await _prefs.setBool(key, value);
    }else if(value is double){
      return await _prefs.setDouble(key, value);
    }else if(value is List<String>){
      return await _prefs.setStringList(key, value);
    }else{
      return false;
    }
  }

  static dynamic getData(String key){
    return _prefs.get(key);
  }
  static Future<void> removeKey(String key)async {
    await _prefs.remove(key);
  }
  static Future<bool> clearData() async{
    return await _prefs.clear();
  }
}