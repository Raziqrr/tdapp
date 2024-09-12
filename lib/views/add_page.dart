/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-09-12 19:53:18
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-09-12 20:50:49
/// @FilePath: lib/views/add_page.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo_upgrade/models/todo_item.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String imagePath = "";
  TextEditingController dateController = TextEditingController();

  void PickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final chosenImage = await imagePicker.pickImage(source: source);
    if (chosenImage != null) {
      imagePath = chosenImage.path;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Enter title", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  hintText: "Enter description", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Select Date", border: OutlineInputBorder()),
              controller: dateController,
              readOnly: true,
              onTap: () async {
                final result = await showDatePicker(
                    initialDate: DateTime.now(),
                    context: context,
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2025));
                if (result != null) {
                  final newDate = DateFormat.MMMMEEEEd().format(result);
                  dateController.text = newDate;
                  setState(() {});
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  PickImage(ImageSource.camera);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.camera),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Camera"),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  PickImage(ImageSource.gallery);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.image),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Gallery"),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ))
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.upload), Text("Upload image")],
                )),
            SizedBox(
              height: 20,
            ),
            imagePath != ""
                ? Stack(alignment: Alignment.topRight, children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        width: MediaQuery.of(context).size.width * 40 / 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(File(imagePath)))),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            imagePath = "";
                          });
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                        )),
                  ])
                : SizedBox(),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  final newItem = ToDoItem(
                      title: titleController.text,
                      isCompleted: false,
                      description: descriptionController.text,
                      imagePath: imagePath != "" ? imagePath : null,
                      date: dateController.text);
                  Navigator.pop(context, newItem);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Add"),
                    SizedBox(
                      width: 30,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
