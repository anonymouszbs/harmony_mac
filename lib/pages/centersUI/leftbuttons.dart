import 'package:flutter/material.dart';
class PercentageButton extends StatelessWidget {
  final int percentage;
  final Function onMinusPressed;
  final Function onPlusPressed;
  const PercentageButton({
    Key? key,
    this.percentage = 0,
    required this.onMinusPressed,
    required this.onPlusPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
     // color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: Colors.white,
            onTap: (){
              
            },
            child: Container(
              width: 40,
              height: 35,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
              
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(Icons.remove),
            ),
          ),
          Text(
            '$percentage%!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: onPlusPressed(),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}