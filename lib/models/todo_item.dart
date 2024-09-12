/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-09-12 18:38:41
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-09-12 20:44:36
/// @FilePath: lib/models/todo_item.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:flutter/material.dart';

class ToDoItem {
  String title;
  bool isCompleted;
  String date;
  String description;
  String? imagePath;

  ToDoItem(
      {required this.title,
      required this.isCompleted,
      required this.date,
      required this.description,
      required this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'isCompleted': this.isCompleted,
      'date': this.date,
      'description': this.description,
      'imagePath': this.imagePath,
    };
  }

  factory ToDoItem.fromMap(Map<String, dynamic> map) {
    return ToDoItem(
      title: map['title'] as String,
      isCompleted: map['isCompleted'] as bool,
      date: map['date'] as String,
      description: map['description'] as String,
      imagePath: map['imagePath'] as String,
    );
  }
}
