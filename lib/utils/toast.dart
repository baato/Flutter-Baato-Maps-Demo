import 'package:fluttertoast/fluttertoast.dart';

abstract final class AppToast {
  AppToast._();

  static void showMessage(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
  }
}
