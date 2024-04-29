import 'package:fluttertoast/fluttertoast.dart';

void showToast(String toastMessage){
  Fluttertoast.showToast(
      msg: toastMessage,
      fontSize: 16.0
  );
}