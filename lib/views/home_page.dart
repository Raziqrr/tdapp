/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-09-12 18:38:28
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2025-03-09 12:09:42
/// @FilePath: lib/views/home_page.dart
/// @Description: Home page of the To-Do app where users can add, view, and manage tasks.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_upgrade/models/todo_item.dart';
import 'package:todo_upgrade/views/add_page.dart';
import 'package:todo_upgrade/views/detail_page.dart';

/// `HomePage` is a StatefulWidget because the UI needs to update dynamically
/// when tasks are added, removed, or modified.
class HomePage extends StatefulWidget {
  /// Constructor of `HomePage
  /// - This is a constant constructor (`const HomePage`) which means if there are no changes in the widget, Flutter can optimize and reuse it.
  /// - `{super.key}`: This passes the unique key to the parent `StatefulWidget` class, helping Flutter track widget updates efficiently.
  const HomePage({super.key});

  /// Creates the state for HomePage
  /// - `createState()` is a method in `StatefulWidget` that tells Flutter:
  ///   "This widget has a state. Here’s the class (`_HomePageState`) that will manage it."
  ///
  /// - `_HomePageState` is a private class (indicated by `_` before the name), meaning it is only accessible within this file.
  /// - The created state (`_HomePageState`) will handle dynamic updates, like adding, removing, or modifying tasks.
  @override
  State<HomePage> createState() => _HomePageState();
}

/// `_HomePageState` manages the state of `HomePage`
class _HomePageState extends State<HomePage> {
  /// List to store all To-Do items.
  /// This list is empty when the app starts and is loaded from storage.
  List<ToDoItem> todoList = [];

  /// Loads the saved to-do list from device storage.
  ///
  /// - Converts the JSON string back into a list of `ToDoItem` objects.
  /// - Updates the UI with `setState()`.
  void LoadList() async {
    /// Start a SharedPreferences instance
    final _prefs = await SharedPreferences.getInstance();

    /// Retrieve the stored list using the key "todoList" just like dictionary with key and value pair concept
    final jsonList = await _prefs.getString("todoList");

    /// Check if data exists before using it
    ///
    /// - `jsonList` is the retrieved stored data (a JSON string).
    /// - If `jsonList` is `null`, it means no tasks were saved before,
    ///   so there's nothing to load, and we can skip processing.
    /// - happends if nothing is saved or key has no data/doesnt exists
    ///
    /// Why is this check important?
    /// - Prevents errors: If we try to decode `null`, it will cause a crash.
    /// - Ensures the app starts with an **empty list** instead of breaking.
    ///
    /// Example scenario:
    /// - First time opening the app → No data is saved → `jsonList == null` → Skip processing.
    /// - If tasks were saved before → `jsonList` has data → Load and display them.
    /// - we know the data is nullable because it has ? symbol on the data type
    /// - whenever datatype has ? symbol, it means it is a nullable datatype where data can be null
    /// - whenever find datatype with ? symbol, always check for null
    if (jsonList != null) {
      /// Convert the JSON string into a list of maps (key-value pairs) by decoding the json
      final mappedList = List<Map<String, dynamic>>.from(jsonDecode(jsonList));

      /// Convert each map into a `ToDoItem` object and store in `todoList`
      /// JSON/String -> Map<String, dynamic> -> ToDoItem
      ///
      /// `mappedList.map((item) => ToDoItem.fromMap(item))`
      ///    - Loops through each item in `mappedList`, which is a list of maps (JSON-like data).
      ///    - Each `item` is a map representing a single to-do task in Map<String, dynamic> form.
      ///
      /// `ToDoItem.fromMap(item)`
      ///    - Takes a single map (`item`) and converts it into a `ToDoItem` object.
      ///    - Uses the `fromMap` factory constructor to transform map data into an instance of `ToDoItem`.
      ///    - fromMap will then returns a ToDOItem from the map that was passed in the function parameter
      ///
      /// `.toList()`
      ///    - After mapping each item, we convert the result back into a list.
      ///    - The final list contains ToDoItem objects, not maps.
      ///
      /// Why do we need this?
      /// - When we save data to `SharedPreferences`, it gets stored as a JSON string.
      /// - When we retrieve it, we **decode it back into a list of maps**.
      /// - But our app works with **ToDoItem objects**, not maps!
      /// - This process **converts maps into usable objects** so we can display tasks properly in the UI.
      ///
      /// - u can use .map() to convert List of a certain datatype into another
      /// - learn to use this
      final tempList =
          mappedList.map((item) => ToDoItem.fromMap(item)).toList();

      /// Assign the converted list to `todoList`
      todoList = tempList;

      /// Update the UI to display the loaded tasks
      /// if no data declared in setState then it reloads everything
      /// for faster development just do this
      /// no need data
      setState(() {});

      /// Debugging: Print loaded data
      /// can try and see difference between data
      /// always use logcat to debug
      /// practice adding print statements for every executable to track errors
      /// practice viewing them in logcat
      print(todoList);
      print(mappedList);
      print(tempList);
    }
  }

  /// Saves the current to-do list to device storage.
  ///
  /// - Converts the list of `ToDoItem` objects into JSON format.
  /// - ToDoItem -> Map<String, dynamic> -> JSON/String
  /// - reverse the process
  /// - Stores the JSON string using `SharedPreferences`.
  void SaveData() async {
    /// Start a SharedPreferences instance
    final _prefs = await SharedPreferences.getInstance();

    /// Convert each `ToDoItem` object into a map and store in a list
    /// by using the .map() concept like before
    final mappedList = todoList.map((item) => item.toMap()).toList();

    /// Convert the list into a JSON string by encoding the map into JSON/string
    final jsonList = jsonEncode(mappedList);

    /// Save the JSON string to device storage
    await _prefs.setString("todoList", jsonList);

    print("Saving");
    print(todoList);
  }

  /// `initState()` is called when the widget is first created.
  ///
  /// - We call `LoadList()` here to fetch saved tasks as soon as the app starts.
  @override
  void initState() {
    LoadList(); // Load saved tasks from storage
    super.initState();
  }

  /// `build()` defines the UI of the home page.
  ///
  /// - Displays a floating button to add tasks.
  /// - Shows a list of to-do items.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Floating action button (FAB) to add new tasks.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          /// Navigate to AddPage and wait for the result
          /// when using await, need async keyword on function {}
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return AddPage();
          }));

          /// If a new task is added, update the list and save it
          /// result could be null because whenever we back from a page, it might not be from the
          /// action of adding a new item but when user clicks the back button
          /// if not checked, it will add when user only clicks the back button (no data to be added)
          /// resulting in an error
          /// this will ensure addition happens when user actually adds a new entry
          if (result != null) {
            print(result);
            todoList.add(result);
            setState(() {}); // Refresh the UI
            /// because we change the data by adding new entry, need to immediately save it in the storage
            SaveData();
          }
        },
        label: Text("Add"),
        icon: Icon(Icons.add),
      ),

      /// App bar (header) of the app
      appBar: AppBar(
        centerTitle: true, // Centers the title text
        title: Text("To Do App"), // App title
      ),

      /// List of to-do items
      body: ListView.builder(
        itemCount: todoList.length,

        /// Number of items in the list, always need to declare list length like for loop, if not then it will run infinitely
        itemBuilder: (BuildContext context, int index) {
          final item = todoList[index]; // Get the current task

          return ListTile(
            /// Navigate to `DetailPage` when tapping an item
            onTap: () async {
              /// fetch the result/the to do item since we want to track changes made inside the detail page
              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return DetailPage(item: item, index: index);
              }));

              /// If changes were made in DetailPage, update the list
              if (result != null) {
                // Update task completion status
                todoList[index].isCompleted = result[0];

                /// since we passed a list, we need to access the result like a list
                /// list is used when trying to pass multiple data
                /// in this case, we also included if the user wants to delete the data from the detail page
                /// If `result[1]` is true, remove the task from the list
                if (result[1] == true) {
                  todoList.removeAt(index);
                }

                /// Save updated list and refresh UI
                SaveData();
                setState(() {});
              }
            },

            /// Display task title and description
            title: Text(item.title),
            subtitle: Text(item.description),

            /// Delete button (removes task when pressed)
            trailing: IconButton(
                onPressed: () {
                  /// for better user experience, proper UI/UX, put warning and ask if user is sure
                  /// this one not good example
                  todoList.removeAt(index); // Remove task from the list
                  setState(() {}); // Refresh UI
                },
                icon: Icon(Icons.delete)),

            /// Show a check icon if the task is completed
            /// condition to show leading icon based on completed
            leading: item.isCompleted == true
                ? IconButton(onPressed: () {}, icon: Icon(Icons.check))
                : null,
          );
        },
      ),
    );
  }
}
