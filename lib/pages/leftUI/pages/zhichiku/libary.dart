import 'package:flutter/material.dart';

class LibaryPage extends StatefulWidget {
  const LibaryPage({Key? key}) : super(key: key);

  @override
  State<LibaryPage> createState() => _LibaryPageState();
}

class _LibaryPageState extends State<LibaryPage> {
  String colorattr = "0xfff5f5f5";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      SizedBox(
        height: 50,
        child:  Row(
          children: [
            Expanded(child:  TextField(
              onChanged: ((value) {
                colorattr = value;
                setState(() {
                  
                });
             }),
            )),
            Expanded(child:  Container(
             color: Color(int.parse(colorattr)),
            ))
          ],

        ),
      )
       
      ],
    ) ;
  }
}