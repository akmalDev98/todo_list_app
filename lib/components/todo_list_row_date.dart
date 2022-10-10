import 'package:flutter/material.dart';

class TodoListRowDate extends StatelessWidget {
  String subTitle = "";
  String item = "";

  TodoListRowDate(this.subTitle,this.item);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        //color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subTitle,style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),),
            Text(item,style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
