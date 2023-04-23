import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HarmonyColorConfig{
  Color hprey = const Color(0xff50556B);
  Color hblack = Get.isDarkMode?Color(0xff00FFDB):Colors.black;
  Color hblue = Colors.blue;
  Color hred = Colors.red;
  Color hgrey = Get.isDarkMode?Colors.transparent:Color(0xffE3E3E3);
  Color hgrey2 = Get.isDarkMode?Color(0xff50556B):Color(0xffF0F0F0);

  Color qjwhite = Get.isDarkMode?Color(0xFFFFFF):Color(0xFF14181B);
  Color hdcolor = Get.isDarkMode?Color(0xFF1D2429):Color(0XFFF2F4F9);
}