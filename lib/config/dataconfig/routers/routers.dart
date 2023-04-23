import 'package:get/get.dart';
import 'package:harmony_mac/pages/index/routers/index_routers.dart';

class Routers{
  static List<GetPage> getAllRouts(){
    return [
      ...IndexPages.routes
    ];
  }
}