import 'package:get/get.dart';

class LeftUIController extends GetxController{
  RxList<bool> isSelected = [true,false,false].obs;
  
  buttonschange(i){
    isSelected.asMap().keys.map((e) => isSelected[e]=false).toList();
    isSelected[i] = true;
  }
}