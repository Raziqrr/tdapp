/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-09-12 20:32:32
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2025-03-09 12:22:02
/// @FilePath: lib/views/detail_page.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_upgrade/models/todo_item.dart';

class DetailPage extends StatefulWidget {
  /// Constructor for DetailPage
  /// - Since both are `required`, the page **must** receive data before it loads.
  const DetailPage({super.key, required this.item, required this.index});

  /// - Passing data between screens in Flutter is similar to defining fields in a class.
  /// - Just like an object receives values through a constructor, pages receive values when they are opened.
  /// - Inside `DetailPage`, these values are stored in `item` and `index`, just like object fields.

  final ToDoItem item;

  /// - Stores the **index** of the task in the to-do list.
  /// - Useful if we need to update or delete this task later.
  final int index;

  /// - `StatefulWidget` needs a `State` class to handle changes in the UI.
  /// - This function returns an instance of `_DetailPageState`,
  ///   which controls how this page behaves.
  @override
  State<DetailPage> createState() => _DetailPageState();
}

/// - Manages the state of the detail page.
/// - Updates UI when marking the task as completed or deleting it.
class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// - Back button (returns to the previous screen).
      /// - Complete button (toggles task completion status).
      /// - Delete button (removes the task).
      appBar: AppBar(
        /// Disables default back button, so we can manually control navigation.
        automaticallyImplyLeading: false,

        /// Custom Back Button
        /// - When pressed, returns to the previous screen.
        /// - Also sends back task completion status**.
        leading: IconButton(
            onPressed: () {
              /// - Returns `isCompleted` value to update the main list.
              /// if have multiple .pop()/backs in a page, we need to ensure the parameter in the pop is consistent
              /// if we return a List in one .pop() in this page the others must also be a List
              /// - `false` means the item was not deleted
              Navigator.pop(context, [widget.item.isCompleted, false]);
            },
            icon: Icon(CupertinoIcons.back)),

        /// Action Buttons
        actions: [
          /// - Toggles `isCompleted` between `true` and `false`.
          /// - Changes icon color: Green (Completed) / Red (Not Completed).
          IconButton(
              onPressed: () {
                /// Toggle task completion status
                widget.item.isCompleted = !widget.item.isCompleted;

                /// `setState` updates the UI to reflect changes.
                /// buat mcmni kalau malas
                setState(() {});
              },
              icon: Icon(
                Icons.check,
                color: widget.item.isCompleted ? Colors.green : Colors.red,
              )),

          /// - When pressed, returns to the previous screen.
          /// - Sends `true` to indicate that the item should be removed.
          IconButton(
              onPressed: () {
                /// **Navigator.pop(context, [widget.item.isCompleted, true])**
                /// - `true` means the task should be deleted.
                /// Since the first pop returns a List with completed and boolean value, here must be the same
                /// value can be different only datatype structure needs to be similar and consistent
                Navigator.pop(context, [widget.item.isCompleted, true]);
              },
              icon: Icon(color: Colors.red, CupertinoIcons.trash))
        ],
      ),

      /// Body: Displays Task Details
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Display Image (if available)
            /// - If the task has an image, show it.
            /// - Uses `Image.file(File(widget.item.imagePath!))` to load from device storage.
            widget.item.imagePath != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 40 / 100,
                          child: Image.file(File(widget.item.imagePath!))),
                    ],
                  )
                : SizedBox(), // If no image, show nothing.

            SizedBox(height: 20),
            Text(widget.item.title),
            SizedBox(height: 20),
            Text(widget.item.description)
          ],
        ),
      ),
    );
  }
}
