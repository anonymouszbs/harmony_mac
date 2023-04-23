
import 'package:get/route_manager.dart';
import 'package:harmony_mac/pages/index/pages/index.dart';

import 'index_page_id.dart';

class IndexPages{
  IndexPages._();
  static final routes = {
    GetPage(name: IndexPageId.home,page: ()=> const IndexPage() ),
    
  };
}