import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyController extends GetxController {
  late OverlayEntry tableUIentry; //右键菜单控制器
  RxList postion = [].obs; //定位数组存放
  RxList table = [].obs; //组件数组存放
  RxList clean = [].obs; //组件数组存放
  RxList showsquare = [].obs; //组件数组存放
  int tableSelectIndex = 0; //现行选中所操作的组件
  bool tableUIentryinit = false; //菜单是否初始化
  GlobalKey paintglobalKey = GlobalKey(); //container 画板的key
  Offset differvalue = Offset(0, 0); //忘了是啥一会儿补充
  RxDouble percentage = 100.0.obs;
  RxDouble scalex = 1.0.obs;
  Offset faceplate = Offset(0, 0);

  Offset d1 = Offset(0, 0);
  // ignore: prefer_final_fields
  List _list = [
    "水平居中",
    "复制组件",
    "上移一层",
    "下移一层",
    "置顶组件",
    "置底组件",
    "删除组件",
  ]; //菜单列表

  initdata() {
    print((paintglobalKey.currentContext?.findRenderObject() as RenderBox)
        .size
        .width);
    faceplate = Offset(
        (paintglobalKey.currentContext?.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero)
            .dx,
        (paintglobalKey.currentContext?.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero)
            .dy);
  }

  ///组件开始拖拽事件
  tableOnStart(details) {
    differvalue = Offset(details.localPosition.dx, details.localPosition.dy);
    d1 = postion[tableSelectIndex][0];
    print(differvalue);
  }

  ///组件拖拽事件
  tableOnUpdate({details, index}) {
    postion[index][0] = Offset(
        d1.dx - -details.localPosition.dx - differvalue.dx,
        d1.dy - -details.localPosition.dy - differvalue.dy);
        print(postion[index][0]);
  }

  ///右键显示菜单
  onSecondaryTapDown({details, context, index}) {
    showtableMENU(context, details);
    tableSelectIndex = index;
    vshowsquare();
  }

  //获取面板的坐标
  getpaintposition() {
    return (paintglobalKey.currentContext?.findRenderObject() as RenderBox)
        .localToGlobal(Offset.zero);
  }

  ///画板接收到拖拽的数据
  onAcceptWithDetails(object) {
    postion.add([
      Offset((object.offset.dx - getpaintposition().dx),
          (object.offset.dy - getpaintposition().dy)),
      const Offset(50, 50)
    ]);
  }

  changeScale() {
    //postion.asMap().keys.map((e) {
    // postion[e][0] = Offset(postion[e][0].dx, postion[e][0].dy-(getpaintposition().dy / 100));
    // postion[e][1] = Offset(postion[e][1].dx*(percentage / 100), postion[e][1].dy*(percentage / 100));
    //}).toList();
  }

  ///拖拽接收数据
  onAccept(object) {
    table.add({object: table.length});

    if (showsquare.isEmpty) {
      print("object");
      showsquare.add(true);
    } else {
      tableSelectIndex = showsquare.length;
      showsquare[showsquare.length - 1] = false;
      showsquare.add(true);
    }
  }

  ///显示包裹的圆圈圈
  vshowsquare() {
    showsquare.asMap().keys.map((e) => showsquare[e] = false).toList();
    showsquare[tableSelectIndex] = true;
    print(showsquare);
  }

//清理
  addlist() {
    clean.add(false);
  }

  ///全局操作关闭菜单
  closetableMENU() {
    tableUIentryinit ? tableUIentry.remove() : null;
    tableUIentryinit = false;
  }

  ///上移一层
  moveUp() {
    if (table.length > 1 && tableSelectIndex < table.length - 1) {
      table.asMap().keys.map((e) {
        var j_table, j_postion;
        if (tableSelectIndex == e) {
          j_table = table[e];
          table[e] = table[e + 1];
          table[e + 1] = j_table;

          j_postion = postion[e];
          postion[e] = postion[e + 1];
          postion[e + 1] = j_postion;
          tableSelectIndex = e + 1;
          vshowsquare();
        }
      }).toList();
      log(table.toString());
    }
  }

  ///下移一层
  moveDown() {
    if (table.length > 1) {
      table.asMap().keys.map((e) {
        var j_table, j_postion;
        if (tableSelectIndex == e) {
          j_table = table[e];
          table[e] = table[e - 1];
          table[e - 1] = j_table;

          j_postion = postion[e];
          postion[e] = postion[e - 1];
          postion[e - 1] = j_postion;
          tableSelectIndex = e - 1;
          vshowsquare();
        }
      }).toList();
      log(table.toString());
    }
  }

  ///置顶组件
  moveTop() {
    if (tableSelectIndex < table.length - 1) {
      print("条件成立");
      var j_table, j_postion;
      j_table = table[tableSelectIndex];
      table.removeAt(tableSelectIndex);
      table.insert(table.length, j_table);
      j_postion = postion[tableSelectIndex];
      postion.removeAt(tableSelectIndex);
      postion.insert(postion.length, j_postion);
      tableSelectIndex = postion.length - 1;
      vshowsquare();
    }
  }

  ///置底组件
  movebottom() {
    if (tableSelectIndex > 0) {
      var j_table, j_postion;

      j_table = table[tableSelectIndex];
      table.removeAt(tableSelectIndex);
      table.insert(0, j_table);
      j_postion = postion[tableSelectIndex];
      postion.removeAt(tableSelectIndex);
      postion.insert(0, j_postion);
      tableSelectIndex = 0;
      vshowsquare();
    }
  }

  ///删除组件
  deleteTable() {
    if (table.isNotEmpty) {
      table.removeAt(tableSelectIndex);
      postion.removeAt(tableSelectIndex);
      showsquare.removeAt(tableSelectIndex);
      if (table.isNotEmpty) {
        tableSelectIndex = table.length - 1;
        vshowsquare();
      }
    }
  }

  ///显示组件菜单
  showtableMENU(context, TapDownDetails details) {
    tableUIentryinit ? tableUIentry.remove() : null;
    tableUIentry = OverlayEntry(builder: (context) {
      tableUIentryinit = true;
      return Positioned(
          top: details.globalPosition.dy,
          left: details.globalPosition.dx,
          child: Material(
              child: Container(
            height: _list.length * 28,
            width: 100,
            child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                String value = _list[index];
                return TextButton(
                    onPressed: () {
                      closetableMENU();
                      switch (value) {
                        case "水平居中":
                          break;
                        case "复制组件":
                          break;
                        case "上移一层":
                          moveUp();
                          break;
                        case "下移一层":
                          moveDown();
                          break;
                        case "置顶组件":
                          moveTop();
                          break;
                        case "置底组件":
                          movebottom();
                          break;
                        case "删除组件":
                          deleteTable();
                          break;
                        default:
                      }
                    },
                    child: Text(value));
              },
            ),
          )));
    });
    Overlay.of(context)?.insert(
      tableUIentry,
    );
  }
}
