

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:harmony_mac/pages/centersUI/controller/bodycontroller.dart';

import '../config/dataconfig/routers/routers.dart';
import '../pages/index/routers/index_page_id.dart';
import '../utils/theme_tool.dart';

class Application extends StatelessWidget {

  Application({Key? key}) : super(key: key);
   late BodyController  bodyController;
  final bottoast = BotToastInit();
  ///全局单击事件
  globalOnTap(){
    bodyController.closetableMENU();

  }
  @override
  Widget build(BuildContext context) {
    bodyController = Get.put(BodyController());
    return ScreenUtilInit(
      designSize:  const Size(800, 600),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (content,child){
        return GestureDetector(
          
          onTap: () => globalOnTap(),
          child: GetMaterialApp(

            initialRoute: IndexPageId.home,
            getPages: Routers.getAllRouts(),
            debugShowCheckedModeBanner: false,
            builder: (context,child)=>MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: bottoast(context,child)),
            theme: ThemeData(brightness: Brightness.light,),
            darkTheme: ThemeData(brightness: Brightness.dark),
            themeMode: Themetool.getlocalprofileaboutThemeModel(),
          ),
        );
      },
    );
  }
}