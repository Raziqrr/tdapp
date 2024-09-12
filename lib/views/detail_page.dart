/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-09-12 20:32:32
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-09-12 21:51:25
/// @FilePath: lib/views/detail_page.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_upgrade/models/todo_item.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.item, required this.index});
  final ToDoItem item;
  final int index;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, [widget.item.isCompleted, false]);
            },
            icon: Icon(CupertinoIcons.back)),
        actions: [
          IconButton(
              onPressed: () {
                widget.item.isCompleted = !widget.item.isCompleted;
                setState(() {});
              },
              icon: Icon(
                Icons.check,
                color:
                    widget.item.isCompleted == true ? Colors.green : Colors.red,
              )),
          IconButton(
              onPressed: () {
                Navigator.pop(context, [widget.item.isCompleted, true]);
              },
              icon: Icon(color: Colors.red, CupertinoIcons.trash))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.item.imagePath != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 40 / 100,
                          child: Image.file(File(widget.item.imagePath!))),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: 20,
            ),
            Text(widget.item.title),
            SizedBox(
              height: 20,
            ),
            Text(widget.item.description)
          ],
        ),
      ),
    );
  }
}
