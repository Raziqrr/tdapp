/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-09-12 18:38:41
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2025-03-09 11:37:04
/// @FilePath: lib/models/todo_item.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:flutter/material.dart';

/// The ToDoItem class represents a task in a to-do list.
/// It is used instead of a Map because:
/// 1. It provides type safety with consistent data type, reducing errors from incorrect key usage.
/// 2. It makes the code easier to understand and accessed with named properties.
/// 3. It allows for new properties and methods can be added without breaking existing code.
class ToDoItem {
  ///define class fields/attributes
  ///after generating constructor, remove final keyword on attributes that can change
  ///just remove all final if unsure, wont effect app that much
  String title;
  bool isCompleted;
  String date;
  String description;
  String? imagePath;

  /// Constructor for creating a new ToDoItem.
  /// Alt+ins/right click, generate Named Argument Constructor
  /// The `required` keyword ensures that all fields must be provided when creating an instance.
  ToDoItem({
    required this.title,
    required this.isCompleted,
    required this.date,
    required this.description,
    required this.imagePath,
  });

  /// Converts the ToDoItem instance to a Map.
  /// Alt+ins/right click, generate toMap and fromMap
  /// This is useful for saving data in storage (e.g., SharedPreferences, databases, JSON serialization).
  /// a function that returns a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    /// returns the Map version after converting from object ToDoItem to Map
    return {
      'title': this.title,
      'isCompleted': this.isCompleted,
      'date': this.date,
      'description': this.description,
      'imagePath': this.imagePath,
    };
  }

  /// Creates a ToDoItem from a Map (key-value pairs).
  ///
  /// This is useful when loading saved data (e.g., from storage or a database or cloud(firebase))
  /// and turning it back into a ToDoItem object.
  ///
  /// Factory Constructor?
  /// - A special type of constructor that controls how objects are created.
  /// - Unlike a normal constructor, it does not always create a new object.
  /// - It is useful when converting data or when you need more control over object creation.
  ///
  /// - We are turning a Map into a ToDoItem object.
  /// - A factory constructor lets us process the data before creating the object.
  /// which provides more control and less error
  factory ToDoItem.fromMap(Map<String, dynamic> map) {
    /// Creates a new ToDoItem using values from the map.
    /// return statement since this is a function with a return type of ToDoItem.
    /// Thus need to return object type ToDoItem
    return ToDoItem(
      title: map['title'].toString(), // Get title as a string.
      isCompleted:
          map['isCompleted'] as bool, // Get completion status as a boolean.
      date: map['date'].toString(), // Get date as a string.
      description:
          map['description'].toString(), // Get description as a string.
      imagePath: map['imagePath'].toString(), // Get image path as a string.
    );
  }
}
