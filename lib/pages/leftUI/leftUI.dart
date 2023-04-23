import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmony_mac/pages/leftUI/controller/leftUIcontroller.dart';
import 'package:harmony_mac/pages/leftUI/pages/gongcheng/project.dart';
import 'package:harmony_mac/pages/leftUI/pages/shuxing/attr.dart';
import 'package:harmony_mac/pages/leftUI/pages/zhichiku/libary.dart';
import 'package:harmony_mac/pages/leftUI/widgets/buttons.dart';

class LeftUIpage extends StatelessWidget {
  const LeftUIpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LeftUIController leftUIController = Get.put(LeftUIController());
    final leftUIheaderitem = {
      Icons.widgets:'支持库',
      Icons.gavel:'工程',
      Icons.edit_attributes:'属性',
    };
    final pageview = [LibaryPage(),Projectpage(),AttrPage()];
    final PageController pageController = PageController(initialPage: 0);
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.vertical,
      children: [
        Container(
          
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: Obx((() =>  Buttons(
          
            height: 40,
            itemswidget: leftUIheaderitem.keys.map((e){
              return Row(
                children: [
                  Icon(e,),
                  Text(leftUIheaderitem[e].toString(),)
                ],
              );
            }).toList(),
            isSelected: leftUIController.isSelected.value,
            onclick: (i){
              leftUIController.buttonschange(i);
              pageController.animateToPage(i, duration: Duration(milliseconds: 200), curve: Curves.linear);
            },
          )))
        ),
            Expanded( child:PageView(
              controller: pageController,
              onPageChanged: (value) {
                
              },
              children: pageview.map((e)=> e).toList(),
             ))
      ],
    );
  }
}
