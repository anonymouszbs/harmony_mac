import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: non_constant_identifier_names
Widget Icontextbutton(
    IconData icon, String data, TextStyle textStyle, double iconsize) {
  return Row(
    children: [
      Icon(
        icon,
        size: iconsize,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        data,
        style: textStyle,
      )
    ],
  );
}

class Dropdown1xialaxuanzekuang extends StatefulWidget {
  final Map sex;
  const Dropdown1xialaxuanzekuang({Key? key, required this.sex})
      : super(key: key);
  @override
  State<Dropdown1xialaxuanzekuang> createState() =>
      _Dropdown1xialaxuanzekuangState();
}

class _Dropdown1xialaxuanzekuangState extends State<Dropdown1xialaxuanzekuang> {
  // ignore: prefer_typing_uninitialized_variables, unused_field
  var _value;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        isExpanded: true,
        hint: const Text(
          '未选择组件',
          style: TextStyle(fontSize: 14),
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
        ),
        iconSize: 25,
        // buttonHeight: 30,
        // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        items: widget.sex.entries.map((e) {
          return DropdownMenuItem(
            value: e.value,
            child: Row(
              children: [
                Icon(
                  e.value,
                  size: 18,
                ),
                Text(e.key)
              ],
            ),
          );
        }).toList(),
        onChanged: (value) => setState(() => _value = value));
  }
}

class SXtable extends StatefulWidget {
  final sex;
  const SXtable({Key? key, this.sex}) : super(key: key);
  @override
  State<SXtable> createState() => _SXtableState();
}

class _SXtableState extends State<SXtable> {
  @override
  Widget build(BuildContext context) {
    final data = [];
    const sex = [
      {'名称': '按钮1'},
      {'宽度': '按钮1'},
      {'高度': '按钮1'},
      {'左边': '按钮1'},
      {'顶边': '按钮1'},
      {'左边距': '按钮1'},
      {'顶边距': '按钮1'},
      {'右边距': '按钮1'},
      {'底边距': '按钮1'},
      {'名称': '按钮1'},
      {'宽度': '按钮1'},
      {'高度': '按钮1'},
      {'左边': '按钮1'},
      {'顶边': '按钮1'},
      {'左边距': '按钮1'},
      {'顶边距': '按钮1'},
      {'右边距': '按钮1'},
      {'底边距': '按钮1'},
      {'名称': '按钮1'},
      {'宽度': '按钮1'},
      {'高度': '按钮1'},
      {'左边': '按钮1'},
      {'顶边': '按钮1'},
      {'左边距': '按钮1'},
      {'顶边距': '按钮1'},
      {'右边距': '按钮1'},
      {'底边距': '按钮1'}
    ];

    sex.map((e) {
      e.entries.map((v) => data.add(_Itembean(v.key, v.value))).toList();
    }).toList();
    return ListView(
      shrinkWrap: true,
      children: [
        Table(
      columnWidths: const <int,TableColumnWidth>{
        0:FixedColumnWidth(10),
        1:FixedColumnWidth(100.0)
      },
      border: TableBorder.all(width: 1.0, color: Colors.grey),
      children: data.map((item) {
        return TableRow(children: <Widget>[Padding(padding: EdgeInsets.all(2.0.h),child: Text(item.name),), Padding(padding: EdgeInsets.all(2.0.h,),child: Text(item.value),)]);
      }).toList(),
    )
      ],
    );
  }
}

class _Itembean {
  String name;
  String value;

  _Itembean(this.name, this.value);
}

class TableDrag extends StatefulWidget {
  final child;
  final dx,dy;
  const TableDrag({Key? key, this.child, this.dx, this.dy}) : super(key: key);

  @override
  State<TableDrag> createState() => _TableDragState();
}

class _TableDragState extends State<TableDrag> {

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.dy,
      left:widget.dx,
      child:  GestureDetector(
        onPanUpdate: (details) {
         details.localPosition.dx;
         details.localPosition.dy;

          setState(() {
            
          });
        },
        child: widget.child,
      ),
      
    );
  }
}