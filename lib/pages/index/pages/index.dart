import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:harmony_mac/pages/centersUI/body.dart';
import 'package:harmony_mac/pages/index/controller/indexcontroller.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with TickerProviderStateMixin {
  late IndexController indexController = Get.put(IndexController());
  @override
  void initState() {
    AnimationController animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    AnimationController animationController1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    AnimationController animationController2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    indexController.leftUIanimationController = animationController;
    indexController.rightUIanimationController = animationController1;
    indexController.bottomUIanimationController = animationController2;
    super.initState();
    var widgetsBinding = WidgetsBinding.instance; //类似android监听app生命周期
    widgetsBinding.addPostFrameCallback((callback) {
      indexController.initstate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: InkWell(
          canRequestFocus: false,
          child: Icon(Icons.tune_sharp),
          onTap: () {
            indexController.showLeftUI(context);
          },
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButtons(
                isSelected: const [false, false, false],
                color: Colors.white,
                splashColor: Colors.white,
                borderWidth: 1,
                borderRadius: BorderRadius.circular(10),
                onPressed: (i) {
                  switch (i) {
                    case 0:
                      break;
                    case 1:
                      break;
                    case 2:
                      break;
                    default:
                  }
                },
                children: const [
                  Icon(
                    Icons.play_arrow,
                    color: Colors.greenAccent,
                  ),
                  Icon(
                    Icons.refresh_outlined,
                    color: Colors.orangeAccent,
                  ),
                  Icon(
                    Icons.square,
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              //用户中心
              Obx(() => Text(indexController.themebutton ? "暗黑" : "正常")),
              Obx(
                () => Switch(
                  value: indexController.themebutton,
                  onChanged: (v) {
                    indexController.settheme(v);
                  },
                ),
              ),
              const Text('未登录'),
              CircleAvatar(
                radius: 20,
                child: InkWell(
                  canRequestFocus: false,
                  onTap: () => print("点击用户头像"),
                  child: const Icon(
                    Icons.people_alt_outlined,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(
                width: 300,
              ),

              InkWell(
                canRequestFocus: false,
                child: Icon(Icons.gamepad_rounded),
                onTap: () {
                  indexController.showRightUI(context);
                },
              ),
            ],
          )
        ],
      ),
      body: BodyPage(),
    );
  }

  Widget leftUI() {
    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Drawer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Text('左侧边栏')],
        ),
      ),
    );
  }

  Widget rightUI() {
    return Drawer(
      elevation: 1,
      child: Text('右侧边栏'),
    );
  }

  Widget centersUI() {
    return Center(
      child: Text('centers'),
    );
  }
}
