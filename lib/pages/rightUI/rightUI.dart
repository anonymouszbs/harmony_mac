import 'package:flutter/material.dart';

import '../../libs/drag/resizable_draggable_widget.dart';


class RightUIPage extends StatelessWidget {
  const RightUIPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.horizontal,children: [
      
      Expanded(flex: 9, child: ListView(
        children: [
         Container(
          height: 100,
          child: Flex(direction: Axis.horizontal,children: [
            Expanded(child: 
            Draggable(child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.5)
              ),
              
              child: Center(child:TextButton.icon(onPressed: (){}, icon: Icon(Icons.bento),label: Text("按钮"),),),
            ), feedback: TextButton.icon(onPressed: (){}, icon: Icon(Icons.ac_unit), label: Text("我是按钮")))
          
         ),
         Expanded(child: 
           Draggable(
              data:Text("我是A"),
              child: Icon(Icons.baby_changing_station),
              feedback: Icon(Icons.telegram_outlined),
            ),
          ),
          Expanded(child: 
           Draggable(
              data:Text("我是B"),
              child: Icon(Icons.baby_changing_station),
              feedback: Icon(Icons.telegram_outlined),
            ),
          ),
          Expanded(child: 
              Draggable(
              data:TextField(),
              child: Icon(Icons.baby_changing_station),
              feedback: Icon(Icons.telegram_outlined),
            ),
          )
          ],)
         )
        ],
      ))
      ,
      Expanded(flex: 1, child: Column(
        children: [
          Icon(Icons.smart_button_sharp),
          Icon(Icons.confirmation_number),
          Icon(Icons.confirmation_number),
        ],
      )),
    ],);
  }
}