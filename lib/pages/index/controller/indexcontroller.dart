import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmony_mac/config/dataconfig/globalvar_config.dart';
import 'package:harmony_mac/pages/leftUI/leftUI.dart';
import 'package:harmony_mac/pages/rightUI/rightUI.dart';

import '../../../components/animations.dart';
import '../../../utils/common_sp_util.dart';
import '../../../utils/theme_tool.dart';

class IndexController extends GetxController {
  bool leftUIisopen = false, rightUIisopen = false,bottomUIisopen=false;
  bool _leftUIopen = false, _rightUIopen = false,_bottomUIopen=false;
  late OverlayEntry leftUIoverlayEntry, rightUIoverlayEntry,bottomUIoverlayEntry;
  late AnimationController rightUIanimationController;
  late AnimationController leftUIanimationController;
  late AnimationController bottomUIanimationController;
  final Rx _themebutton = false.obs;
  bool get themebutton => _themebutton.value;
  
  initstate(context){
    showLeftUI(context);
    showRightUI(context);
    showBottomUI(context);
  }

  settheme(v){
    _themebutton.value = !_themebutton.value;
    CommonSpUtil.saveThemeType(type: 2);
    Themetool.changeTheme();
  }
  showBottomUI(context) {
    if (_bottomUIopen == false) {
      _bottomUIopen = true;
      bottomUIisopen = true;
      show(
          context: context,
          animationController: bottomUIanimationController,
          tab: headtcontroller.bottom);

    } else {
      bottomUIisopen == true
          ? bottomUIanimationController.animateTo(0)
          : bottomUIanimationController.forward();
      bottomUIisopen = !bottomUIisopen;
    }
  }

  showLeftUI(context) {
    if (_leftUIopen == false) {
      _leftUIopen = true;
      leftUIisopen = true;
      show(
          context: context,
          animationController: leftUIanimationController,
          tab: headtcontroller.LEFT);

    } else {
      leftUIisopen == true
          ? leftUIanimationController.animateTo(0)
          : leftUIanimationController.forward();
      leftUIisopen = !leftUIisopen;
    }
  }

  showRightUI(context) {
    
    if (_rightUIopen == false) {
      _rightUIopen = true;
      rightUIisopen = true;
      print('hah');
      show(
          context: context,
          animationController: rightUIanimationController,
          tab: headtcontroller.RIGHT);
    } else {
      
      if (rightUIisopen == true) {
        
        rightUIisopen = false;
        rightUIanimationController.animateTo(0);
      } else {
        rightUIisopen = true;
        rightUIanimationController.forward();
      }
    }
  }

  void show(
      {required BuildContext context,
      required animationController,
      required tab}) {
    switch (tab) {
      case headtcontroller.LEFT:
        leftUIoverlayEntry = OverlayEntry(builder: (context) {
          return AnimationsPY(
            frame: LeftUIpage(),
            animationController: animationController,
            tab: tab,
          );
        });
        Overlay.of(context)?.insert(leftUIoverlayEntry);
        break;
      case headtcontroller.RIGHT:
        rightUIoverlayEntry = OverlayEntry(builder: (context) {
          return AnimationsPY(
            frame:RightUIPage(),
            animationController: animationController,
            tab: tab,
          );
        });
        Overlay.of(context)?.insert(rightUIoverlayEntry,);
        break;
      case headtcontroller.bottom:
        bottomUIoverlayEntry = OverlayEntry(builder: (context) {
          return AnimationsPY(
            frame: Column(
              children: [],
            ),
            animationController: animationController,
            tab: tab,
          );
        });
        Overlay.of(context)?.insert(bottomUIoverlayEntry,);
        break;  
      default:
    }

    //延时两秒，移除 OverlayEntry
    //  Future.delayed(Duration(seconds: 20)).then((value) {
    //   overlayEntry.remove();
    // });
  }
}
