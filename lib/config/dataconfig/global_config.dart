

import 'package:flutter/material.dart';

import '../../utils/sp_util.dart';


class GloblConfig{
  static init()async{
    WidgetsFlutterBinding.ensureInitialized();
    await initthirdparty();
  }
  static initthirdparty()async{
    //初始化数据库
    await SpUtil.getInstance();
    //初始化自动布局
    
  }
}