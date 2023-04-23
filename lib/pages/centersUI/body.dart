import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:harmony_mac/config/dataconfig/globalvar_config.dart';
import 'package:harmony_mac/pages/centersUI/controller/bodycontroller.dart';
import 'package:harmony_mac/pages/leftUI/widgets/buttons.dart';

class BodyPage extends StatefulWidget {
  const BodyPage({Key? key}) : super(key: key);

  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  //操作
  ///控制大小的变量

  double trH = 0;
  double trW = 0;
  double trLastH = 0;
  double trLastW = 0;
  double coordinateW = 0, coordinateH = 0; //坐标xy

  Offset _offset = Offset.zero;
  Map<Icon, String> add = {};
  late BodyController bodyController;

  ///移动变量
  Offset startMoveOffset = const Offset(0, 0);
  Offset endMoveOffset = const Offset(0, 0);
  Offset updateMoveOffset = const Offset(0, 0);

  late FocusNode focusNode;
  late Matrix4 _m4;

  double _dynamicSH = 0;
  double _dynamicSW = 0;

  //面板变大变小
 

 //改变日头
 bool moon = false;
 bool iphone = false;
  
  @override
  void initState() {
    _m4 = Matrix4.identity();
    super.initState();
    focusNode = FocusNode();
    var widgetBinding = WidgetsBinding.instance;
    widgetBinding.addPostFrameCallback((timeStamp) {
      bodyController.initdata();
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        // 处理上键
        bodyController.postion[bodyController.tableSelectIndex][0] = Offset(
            bodyController.postion[bodyController.tableSelectIndex][0].dx,
            bodyController.postion[bodyController.tableSelectIndex][0].dy - 1);
        setState(() {});
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        bodyController.postion[bodyController.tableSelectIndex][0] = Offset(
            bodyController.postion[bodyController.tableSelectIndex][0].dx,
            bodyController.postion[bodyController.tableSelectIndex][0].dy + 1);
        setState(() {});
        print('Down key pressed');
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        bodyController.postion[bodyController.tableSelectIndex][0] = Offset(
            bodyController.postion[bodyController.tableSelectIndex][0].dx - 1,
            bodyController.postion[bodyController.tableSelectIndex][0].dy);
        setState(() {});
        // 处理左键
        print('Left key pressed');
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        bodyController.postion[bodyController.tableSelectIndex][0] = Offset(
            bodyController.postion[bodyController.tableSelectIndex][0].dx + 1,
            bodyController.postion[bodyController.tableSelectIndex][0].dy);
        setState(() {});
        // 处理右键
        print('Right key pressed');
      } else if (event.logicalKey == LogicalKeyboardKey.delete) {
        bodyController.deleteTable();
      }
    }
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    bodyController = Get.put(BodyController());

    return GetBuilder<BodyController>(builder: (bodyController) {
      return RawKeyboardListener(
          focusNode: focusNode,
          onKey: (event) => _handleKeyEvent(event),
          child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.2),
              color: Get.isDarkMode
                  ? const Color(0xff1E2428)
                  : const Color(0xffF2F4F8),
              child: Stack(
                children: [
                  DragTarget(
                    builder: ((context, candidateData, rejectedData) {
                      return Obx(() => Transform(
                          transform: Matrix4.identity()
                            ..translate(_offset.dx, _offset.dy)
                            ..scale(bodyController.scalex.value),
                          child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                  onPanUpdate: ((details) {
                                    setState(() {
                                      _offset += details.delta;
                                    });
                                  }),
                                  child: Container(
                                      decoration:iphone? BoxDecoration(
                                      image: DecorationImage(image: AssetImage("img/iphone13promax.png"),fit: BoxFit.fill),
                                      borderRadius: BorderRadius.all(Radius.circular(26.0))
                                    ):null,
                                     padding: EdgeInsets.all(25),
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.all(Radius.circular(iphone?30.0:0.0)),
                                    //       boxShadow: [
                                    //         BoxShadow(
                                    //             color: moon
                                    //                 ? const Color(0xff1A1F25)
                                    //                 : const Color(0xffF2F4F8))
                                    //       ],
                                    //       border: Border.all(
                                    //           width: 0.5, color: Colors.grey)),
                                      key: bodyController.paintglobalKey,
                                      // color:Get.isDarkMode?Color(0xff1A1F25):Color(0xffF2F4F8),
                                      height: 640,
                                      width: 360,
                                      alignment: Alignment.center,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: bodyController.table
                                            .asMap()
                                            .keys
                                            .map((e) {
                                          var _child;
                                          bodyController.table[e].entries
                                              .map((listmap) {
                                            _child = listmap.key;
                                          }).toList();
                                          // return Container();
                                          return Positioned(
                                              left: bodyController
                                                  .postion[e][0].dx,
                                              top: bodyController
                                                  .postion[e][0].dy,
                                              child: Stack(
                                                alignment: Alignment.topCenter,
                                                children: [
                                                  GestureDetector(
                                                      onPanDown: ((details) {
                                                        focusNode
                                                            .requestFocus();
                                                        bodyController
                                                            .tableSelectIndex = e;
                                                        bodyController
                                                            .vshowsquare();

                                                        setState(() {});
                                                      }),
                                                      onPanStart: (details) {
                                                        bodyController
                                                            .tableOnStart(
                                                                details);
                                                        setState(() {});
                                                      },
                                                      onPanUpdate: (details) {
                                                        bodyController
                                                            .tableOnUpdate(
                                                                details:
                                                                    details,
                                                                index: e);
                                                        setState(() {});
                                                      },
                                                      onSecondaryTapDown:
                                                          (TapDownDetails
                                                              details) {
                                                        focusNode
                                                            .requestFocus();

                                                        bodyController
                                                            .onSecondaryTapDown(
                                                                details:
                                                                    details,
                                                                index: e,
                                                                context:
                                                                    context);

                                                        setState(() {});
                                                      },
                                                      child: pancontroller(
                                                          tchild: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width:
                                                                bodyController
                                                                    .postion[e]
                                                                        [1]
                                                                    .dx,
                                                            height:
                                                                bodyController
                                                                    .postion[e]
                                                                        [1]
                                                                    .dy,
                                                            color: Colors.blue,
                                                            child: _child,
                                                          ),
                                                          posi: e,
                                                          showsquare:
                                                              bodyController
                                                                      .showsquare[
                                                                  e])),
                                                ],
                                              ));
                                        }).toList(),
                                      ))))));
                    }),
                    onAccept: (object) {
                      bodyController.onAccept(object);
                    },
                    onAcceptWithDetails: (object) {
                      bodyController.onAcceptWithDetails(object);
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                  ),
                  Positioned(
                    left: 330,
                    top: 10,
                    child: SizedBox(
                      width: 150,
                      height: 35,
                      child: ToggleButtons(
                          selectedColor: Colors.cyan,
                          onPressed: (i) {
                            switch (i) {
                              case 0:
                                bodyController.scalex.value > 0.3
                                    ? bodyController.scalex.value -= 0.1
                                    : null;
                                setState(() {});
                                break;
                              case 2:
                                bodyController.scalex.value < 2.0
                                    ? bodyController.scalex.value += 0.1
                                    : null;
                                setState(() {});
                                break;
                              default:
                            }
                          },
                          children: [
                            Icon(
                              Icons.remove,
                            ),
                            Text(
                              "${(bodyController.scalex.value * 100).toInt()}%",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.add,
                            )
                          ],
                          isSelected: const [
                            true,
                            false,
                            true
                          ]),
                    ),
                  ),
                  Positioned(
                      right: 320,
                      top: 10,
                      child: SizedBox(
                          width: 100,
                          height: 35,
                          child: ToggleButtons(
                            onPressed: (i){
                              setState(() {
                                i==0?moon = !moon:iphone = !iphone;
                              });
                            },
                            children: [
                            Icon(moon?Icons.brightness_2:Icons.sunny),
                            Icon(Icons.phone_iphone)
                          ], isSelected: [
                            moon?true:false,
                            iphone?true:false
                          ])))
                ],
              )));
    });
  }

  pancontroller({required Widget tchild, posi, showsquare}) {
    Offset wh = bodyController.postion[posi][1] *
        (bodyController.percentage.value / 100);
    return Stack(
      children: [
        tchild,
        Positioned(
          left: 0,
          top: 0,
          child: panResizeSquare(flowvar.topleft, showsquare),
        ),
        Positioned(
          left: (wh.dx / 2) - 5,
          top: 0,
          child: panResizeSquare(flowvar.topcenter, showsquare),
        ),
        Positioned(
          left: wh.dx - 10,
          top: 0,
          child: panResizeSquare(flowvar.topright, showsquare),
        ),
        Positioned(
          left: 0,
          top: wh.dy / 2 - 5,
          child: panResizeSquare(flowvar.centerleft, showsquare),
        ),
        Positioned(
          left: wh.dx - 10,
          top: wh.dy / 2 - 5,
          child: panResizeSquare(flowvar.centerright, showsquare),
        ),
        Positioned(
          left: 0,
          top: wh.dy - 10,
          child: panResizeSquare(flowvar.bottomleft, showsquare),
        ),
        Positioned(
          left: (wh.dx / 2) - 5,
          top: wh.dy - 10,
          child: panResizeSquare(flowvar.bottomcenter, showsquare),
        ),
        Positioned(
          left: wh.dx - 10,
          top: wh.dy - 10,
          child: panResizeSquare(flowvar.bottomright, showsquare),
        )
      ],
    );
  }

  Offset _panStartOffset = const Offset(0, 0);
  Offset _panUpdateOffset = const Offset(0, 0);
  Offset _panIntervalOffset = const Offset(0, 0);

  ///改变大小套圈呢
  ///
  panResizeSquare(type, showsquare) {
    return GestureDetector(
      onPanUpdate: (details) {
        _panUpdateOffset = details.localPosition;
        switch (type) {
          case flowvar.topleft: //top left都得动
            _panIntervalOffset = _panUpdateOffset - _panStartOffset;
            refreshW(type, _panIntervalOffset.dx);
            refreshH(type, _panIntervalOffset.dy);
            break;
          case flowvar.topcenter: //只动dy
            _panIntervalOffset = _panUpdateOffset - _panStartOffset;
            refreshH(type, _panIntervalOffset.dy);
            break;

          case flowvar.topright: //只动dy
            _panIntervalOffset = _panUpdateOffset - _panStartOffset;
            refreshW(type, -_panIntervalOffset.dx);
            refreshH(type, _panIntervalOffset.dy);
            break;
          case flowvar.centerleft: //只动dy
            _panIntervalOffset = _panUpdateOffset - _panStartOffset;
            refreshW(type, _panIntervalOffset.dx);
            break;
          case flowvar.centerright: //只动dy
            _panIntervalOffset = -_panUpdateOffset + _panStartOffset;
            refreshW(type, _panIntervalOffset.dx);
            break;
          case flowvar.bottomleft: //只动dy
            _panIntervalOffset = -_panUpdateOffset + _panStartOffset;
            refreshW(type, -_panIntervalOffset.dx);
            refreshH(type, _panIntervalOffset.dy);
            break;
          case flowvar.bottomright:
            _panIntervalOffset = -_panUpdateOffset + _panStartOffset;
            refreshW(type, _panIntervalOffset.dx);
            refreshH(type, _panIntervalOffset.dy);
            break;
          case flowvar.bottomcenter: //只动dy
            _panIntervalOffset = -_panUpdateOffset + _panStartOffset;
            refreshH(type, _panIntervalOffset.dy);
            break;
          default:
        }
        //   bodyController.postion[bodyController.tableSelectIndex][1] = _panUpdateOffset+_panStartOffset;
      },
      onPanStart: (details) {
        _panStartOffset = details.localPosition;
        _dynamicSW =
            bodyController.postion[bodyController.tableSelectIndex][1].dx; //宽
        _dynamicSH =
            bodyController.postion[bodyController.tableSelectIndex][1].dy; //高
        coordinateW =
            bodyController.postion[bodyController.tableSelectIndex][0].dx;
        coordinateH =
            bodyController.postion[bodyController.tableSelectIndex][0].dy;
        print(_panStartOffset);
      },
      onPanEnd: ((details) {
        trLastH = trH;
        _lockH = false;
        trLastW = trW;
        _lockW = false;
      }),
      child: Visibility(
        visible: showsquare,
        child: Container(
          color: Colors.white,
          child: Icon(
            color: Colors.blue,
            size: 10,
            Icons.crop_square,
          ),
        ),
      ),
    );
  }

  bool _lockW = true, _lockH = true;

  refreshW(flowvar dir, double dx) {
    // if (bodyController.postion[bodyController.tableSelectIndex][1].dx < 40 &&
    //     _panIntervalOffset.dx > 0) {
    //   _lockW = true;
    //   bodyController.postion[bodyController.tableSelectIndex][1] = Offset(
    //       40, bodyController.postion[bodyController.tableSelectIndex][1].dy);
    // }
    // if (_panIntervalOffset.dx < 0) {
    //   _lockW = false;
    // }

    if (!_lockW) {
      if (_dynamicSW - dx > 0) {
        setState(() {
          bodyController.postion[bodyController.tableSelectIndex][1] = Offset(
              _dynamicSW - dx,
              bodyController.postion[bodyController.tableSelectIndex][1].dy);
          if (dir == flowvar.centerleft ||
              dir == flowvar.topleft ||
              dir == flowvar.bottomleft) {
            trW = dx + trLastW;
            print(dx);
            bodyController.postion[bodyController.tableSelectIndex][0] = Offset(
                coordinateW + dx,
                bodyController.postion[bodyController.tableSelectIndex][0].dy);
          }
        });
      }
    }
  }

  refreshH(flowvar dir, double dy) {
    // if (bodyController.postion[bodyController.tableSelectIndex][1].dy < 40 &&
    //     _panIntervalOffset.dy > 0) {
    //   _lockH = true;
    //   bodyController.postion[bodyController.tableSelectIndex][1] = Offset(
    //       bodyController.postion[bodyController.tableSelectIndex][1].dx, 40);
    // }
    // if (_panIntervalOffset.dy < 0) {
    //   _lockH = false;
    // }

    if (!_lockH) {
      if (_dynamicSH - dy > 0) {
        setState(() {
          bodyController.postion[bodyController.tableSelectIndex][1] = Offset(
              bodyController.postion[bodyController.tableSelectIndex][1].dx,
              _dynamicSH - dy);
          if (dir == flowvar.topcenter ||
              dir == flowvar.topleft ||
              dir == flowvar.topright) {
            trH = dy + trLastH;
            bodyController.postion[bodyController.tableSelectIndex][0] = Offset(
                bodyController.postion[bodyController.tableSelectIndex][0].dx,
                coordinateH + dy);
          }
        });
      }
    }
  }
}
