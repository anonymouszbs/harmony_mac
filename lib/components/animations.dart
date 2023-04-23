import 'package:flutter/material.dart';
import 'package:harmony_mac/config/dataconfig/globalvar_config.dart';

class AnimationsPY extends StatefulWidget {
  //平移动化
  final frame;
  final animationController;
  final tab;

  const AnimationsPY({Key? key, required this.frame,required this.animationController,required this.tab})
      : super(key: key);

  @override
  State<AnimationsPY> createState() => _AnimationsPYState();
}

class _AnimationsPYState extends State<AnimationsPY>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
 
    widget.animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    widget.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.tab==headtcontroller.bottom?
    Container(
      alignment: Alignment.bottomCenter,
      // padding: EdgeInsets.only(top:40),
      child:  SizeTransition(
          axis: Axis.vertical,
          child: Material(
              child: Container(
              
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
                ),
            width:  MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.2,
            child: Center(
              child: widget.frame,
            ),
          )),
          sizeFactor: CurvedAnimation(
              parent: widget.animationController, curve: Curves.easeInToLinear)),
    
    )
     :Container(
      alignment: widget.tab==headtcontroller.LEFT?Alignment.topLeft:Alignment.topRight,
      padding: EdgeInsets.only(top:40),
      child:  SizeTransition(
          axis: Axis.horizontal,
          child: Material(
              child: Container(
              
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
              ),
            width: 320,
            height: MediaQuery.of(context).size.height*0.8,
            child: Center(
              child: widget.frame,
            ),
          )),
          sizeFactor: CurvedAnimation(
              parent: widget.animationController, curve: Curves.easeInToLinear)),
    
    );
  }
}
