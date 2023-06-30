import 'package:flutter/cupertino.dart';
import 'package:study_better/utils/local_storage.dart';

class JwtProvider extends ChangeNotifier {
  String _jwt = "";

  String get jwt => _jwt;

  void init() async {
    await Future.delayed(const Duration(seconds: 1));
    String? tempJwt = await LocalStorage.getJWT();
    if (tempJwt.isNotEmpty) {
      _jwt = tempJwt;
    }
  }

  void setJwt(String newToken) {
    _jwt = newToken;
    LocalStorage.saveJWT(jwtToSave: newToken);
    notifyListeners();
  }
}
