import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  String _jwt = "";

  String get jwt => _jwt;

  void setJwt(String newJwt){
    _jwt = newJwt;
    notifyListeners();
    // local storage a kaydetmek daha mantıklı kapatıp açınca login olmasın tekrardan
  }
}