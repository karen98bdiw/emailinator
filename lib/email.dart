import 'package:flutter/cupertino.dart';

class Email extends ChangeNotifier {
  String title;
  String content;

  String sender;
  String mainRecepient;

  Email({this.title, this.content});

  List<String> recepinets = [];

  addRecepient(String email) {
    recepinets.add(email);
    print("recepinet${recepinets.length}");
    notifyListeners();
  }

  void deleteRecepien(String email) {
    recepinets.removeWhere((element) => element == email);
    notifyListeners();
  }
}
