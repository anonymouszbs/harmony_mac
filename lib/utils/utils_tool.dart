import 'dart:io';

class Utilstool{
  //判断为什么操作系统

  getOSType(){
    if (Platform.isWindows) {
      return "win";
    } else if (Platform.isMacOS) {
      return "mac";
    }
  }
}