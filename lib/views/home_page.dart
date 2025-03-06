/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-09-12 18:38:28
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2025-03-06 15:31:14
/// @FilePath: lib/views/home_page.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_upgrade/models/todo_item.dart';
import 'package:todo_upgrade/views/add_page.dart';
import 'package:todo_upgrade/views/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List to store to do items, initiliaze as empty list and load when launching app
  List<ToDoItem> todoList = [];

  //function to load list from device storage
  void LoadList() async {
    //starting shared preference instance
    final _prefs = await SharedPreferences.getInstance();

    //getting the data stored by accessing named key todoList
    final jsonList = await _prefs.getString("todoList");

    //check if data exists/not null
    if (jsonList != null) {
      //converting the json string into list of map
      final mappedList = List<Map<String, dynamic>>.from(jsonDecode(jsonList));

      //converting the all items in the list into ToDoItem object instances by mapping each items into ToDoItem and converting them back into a list
      final tempList =
          mappedList.map((item) => ToDoItem.fromMap(item)).toList();
      todoList = tempList;
      setState(() {}); //set state for all
      print(todoList);
      print(mappedList);
      print(tempList);
    }
  }

  void SaveData() async {
    //start shared preferences instance
    final _prefs = await SharedPreferences.getInstance();
    final mappedList = todoList.map((item) => item.toMap()).toList();
    final jsonList = jsonEncode(mappedList);
    await _prefs.setString("todoList", jsonList);
    print("Saving");
    print(todoList);
  }

  @override
  void initState() {
    // TODO: implement initState
    LoadList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return AddPage();
          }));
          if (result != null) {
            print(result);
            todoList.add(result);
            setState(() {});
            SaveData();
          }
        },
        label: Text("Add"),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("To Do App"),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = todoList[index];
          return ListTile(
            onTap: () async {
              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return DetailPage(item: item, index: index);
              }));

              if (result != null) {
                todoList[index].isCompleted = result[0];
                if (result[1] == true) {
                  todoList.removeAt(index);
                }
                SaveData();
                setState(() {});
              }
            },
            title: Text(item.title),
            subtitle: Text(item.description),
            trailing: IconButton(
                onPressed: () {
                  todoList.removeAt(index);
                  setState(() {});
                },
                icon: Icon(Icons.delete)),
            leading: item.isCompleted == true
                ? IconButton(onPressed: () {}, icon: Icon(Icons.check))
                : null,
          );
        },
      ),
    );
  }
}
