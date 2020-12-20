import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveLastViewed(int lastViewed) async {
  final localData = await SharedPreferences.getInstance();
  localData.setString('lastViewed', '$lastViewed');
}

Future<int> getSavedData() async {
  final localData = await SharedPreferences.getInstance();
  String l = localData.get('lastViewed');
  int lastViewed = int.parse(l);
  return lastViewed;
}

class CommonProvider extends ChangeNotifier {
  int lastViewed = 0;
  List all = [];
  List searchResults = [];

  void setLastViewed(int time) {
    lastViewed = time;
    notifyListeners();
    saveLastViewed(lastViewed);
  }

  void getLastViewed() async {
    lastViewed = await getSavedData() ?? 0;
    notifyListeners();
  }
}
