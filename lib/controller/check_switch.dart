import 'package:get/get.dart';

class IsSwitched extends GetxController{
  var isSwitched = false.obs;
  void changeSwitch (bool value){
    isSwitched.value=value;
  }
}