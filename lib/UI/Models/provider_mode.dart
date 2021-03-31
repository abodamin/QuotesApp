import 'package:QuatesApp/App/shared_prefrence.dart';
import 'package:flutter/foundation.dart';

class ProviderModel extends ChangeNotifier {
  bool darkMode;

  ProviderModel({
    this.darkMode = false,
  });

  void setDarkMode() {
    if (darkMode) {
      this.darkMode = false;
    } else {
      this.darkMode = true;
    }
    notifyListeners();
  }
}
