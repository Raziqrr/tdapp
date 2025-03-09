/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-09-12 19:53:18
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2025-03-09 12:57:30
/// @FilePath: lib/views/add_page.dart
/// @Description: This file contains the `AddPage` where users can create new to-do items.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo_upgrade/models/todo_item.dart';

class AddPage extends StatefulWidget {
  /// Constructor for AddPage
  /// - Since no data is passed to this page, the constructor is simple/default
  /// we dont need data since its a form to create new entry
  const AddPage({super.key});

  /// - A `StatefulWidget` needs a `State` class to handle UI updates.
  /// since we want the form to show values, we need to update it
  /// everytime create page, just use stateful because its easier
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  /// Controllers for User Input Fields
  ///
  /// In Flutter, `TextEditingController` is used to control text fields.
  /// It allows retrieving, modifying, and clearing the text entered by the user.
  ///
  /// - `dateController`:
  ///   - Stores the selected date when the user picks a date from the calendar.
  ///   - The date is formatted as a string for display.
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  /// Stores the path of the selected image
  /// - Default is an empty string (`""`), meaning no image has been selected yet.
  String imagePath = "";

  /// Function to Pick an Image
  ///
  /// This function allows the user to pick an image from either (based on image source):
  /// - The camera (takes a new photo).
  /// - The gallery (selects an existing photo).
  ///
  /// 1. Creates an instance of `ImagePicker`, which is a Flutter plugin for accessing the device’s camera and gallery.
  /// 2. Uses `pickImage(source: source)` to open the camera or gallery, depending on the provided `source`.
  /// 3. If the user selects an image:
  ///    - Saves the image file path in the variable `imagePath`.
  /// 4. Calls `setState()` to update the UI so the selected image is displayed.
  ///
  /// - source parameter: Defines whether the image is picked from the **camera** or **gallery**.
  ///
  /// UI Update:
  /// - If an image is selected, it will be displayed on the screen.
  /// - If the user cancels, nothing happens.
  void PickImage(ImageSource source) async {
    /// Create an instance of ImagePicker
    final imagePicker = ImagePicker();

    /// Open the camera or gallery based on the provided source
    /// need to wait until user picks an image before continuing
    final chosenImage = await imagePicker.pickImage(source: source);

    /// Check if the user selected an image (not canceled)
    /// user can exit image selection thus returning null
    /// so need to check
    if (chosenImage != null) {
      imagePath = chosenImage.path; // Save the selected image path
    }

    /// Alternative: Store Image as Bytes Instead of File Path
    ///
    /// By default, we store only the image path (`imagePath`). However,
    /// another approach is to **store the image as bytes (`Uint8List`),
    ///
    /// Why Use Bytes Instead of a File Path?
    /// - The image path only works locally (not useful for cloud storage).
    /// - Storing images as `bytes` allows direct database storage as a `String`.
    /// - We can convert `bytes` to a `Base64` string (`base64Encode(bytes)`)
    ///   and store it in Firestore, Supabase, or any other cloud DB.
    ///
    /// How This Works:
    /// 1. Check if an image was selected (`chosenImage != null`).
    /// 2. Read the image as bytes using `File(chosenImage.path).readAsBytes()`.
    /// 3. If successful:
    ///    - Store `imageData` in `image` (as `Uint8List`).
    ///    - Store the `imagePath` (optional, can use for UI display).
    ///    - Call `setState()` to **refresh the UI**.
    /// 4. Close the image selection modal (`Navigator.pop(context)`).
    ///
    /// Note:
    /// - Large images** will take up more storage** if stored as `String`.
    /// - If storing images locally, it's better to save them as files
    ///   and only save their path in the database.
    // if (chosenImage != null) {
    //   final imageData = await File(chosenImage.path).readAsBytes(); // convert to bytes
    //   if (imageData != null) {
    //     setState(() {
    //       image = imageData; // Store the image as bytes
    //       imagePath = chosenImage.name; // Save image name (optional)
    //     });
    //     Navigator.pop(context); // Close the modal bottom sheet
    //   }
    // }

    /// Trigger a UI update to show the selected image
    setState(() {});
  }

  /// Function to Show Image Source Selection Modal
  /// not implemented here but can use instead of calling 2 different PickImage
  ///
  /// This function displays a bottom sheet modal that lets the user choose
  /// whether to pick an image from the camera or gallery.
  ///
  /// 1. Initializes `source` as `ImageSource.camera` (default value).
  /// 2. Displays a modal bottom sheet using `showModalBottomSheet()`.
  /// 3. Inside the modal:
  ///    - The user sees **two buttons**: "Camera" and "Gallery".
  ///    - When the user taps a button:
  ///      - The `source` variable is set accordingly (`ImageSource.camera` or `ImageSource.gallery`).
  ///      - The modal is dismissed using `Navigator.pop(context)`.
  /// 4. Once the modal is closed, the function **returns** the selected `ImageSource`.
  ///
  /// Parameters:
  /// - `context`: The `BuildContext` required to show the modal bottom sheet.
  ///
  /// Return Value:
  /// - A `Future<ImageSource>` that it value is either:
  ///   - `ImageSource.camera` (if the user selects "Camera").
  ///   - `ImageSource.gallery` (if the user selects "Gallery").
  ///
  /// UI Behavior:
  /// - The modal is dismissed once an option is selected.
  /// - If the user taps outside the modal, it closes without making a selection.
  ///
  // Future<ImageSource> pickMethod(BuildContext context) async {
  //   // Default image source is set to the camera
  //   ImageSource source = ImageSource.camera;
  //
  //   // Show a bottom sheet modal where the user can choose the image source
  //   await showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Column(
  //         mainAxisSize: MainAxisSize.min, // Make the modal as small as possible
  //         children: [
  //           // Camera selection button
  //           ElevatedButton(
  //             onPressed: () {
  //               source = ImageSource.camera; // Set source to camera
  //               Navigator.pop(context); // Close the modal
  //             },
  //             child: Text("Camera"),
  //           ),
  //
  //           // Gallery selection button
  //           ElevatedButton(
  //             onPressed: () {
  //               source = ImageSource.gallery; // Set source to gallery
  //               Navigator.pop(context); // Close the modal
  //             },
  //             child: Text("Gallery"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //
  //   // Return the selected image source after modal is closed
  //   return source;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Item"),
      ),
      body: Padding(
        ///adding padding to the page so we wrap the column
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(

                  ///change TextField design using OutlineInputBorder()
                  hintText: "Enter title",
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  hintText: "Enter description", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),

            /// Date Picker Field
            ///
            /// This `TextField` allows the user to select a date by opening
            /// a calendar pop-up (`showDatePicker`) when tapped.
            /// user cannot type since its read only, this allows input to be only from the DatePicker
            ///
            /// How it Works:
            /// 1. The `TextField` is read-only meaning users cannot type manually.
            /// 2. When tapped, `showDatePicker` opens a calendar dialog.
            /// 3. The user selects a date.
            /// 4. If a date is selected:
            ///    - It is formatted using `DateFormat.MMMMEEEEd()` (e.g., "March 9, 2025"). can view date formats in documentation (maybe)
            ///    https://api.flutter.dev/flutter/intl/DateFormat-class.html
            ///    - The formatted date is stored in `dateController.text`.
            ///    - `setState()` is called to update the UI and reflect the new date in the TextField value.
            ///
            /// Parameters & Behavior:
            /// - `initialDate`: Defaults to today's date (`DateTime.now()`).
            /// - `firstDate`: Earliest selectable date (January 1, 2023). acts as minimum
            /// - `lastDate`: Latest selectable date (December 31, 2025). acts as maximum
            /// - If the user taps outside the calendar or presses Cancel, no changes are made.
            ///
            /// Example:
            /// - User taps the field → Calendar opens.
            /// - Selects "March 9, 2025" → TextField displays `"Sunday, March 9, 2025"`.
            ///
            TextField(
              decoration: InputDecoration(
                  hintText: "Select Date", // Placeholder text
                  border: OutlineInputBorder()), // Adds a border
              controller: dateController,

              /// Read-Only: Prevents manual typing
              readOnly: true,

              /// Handle Tap to Open DatePicker
              onTap: () async {
                // Open DatePicker dialog
                final result = await showDatePicker(
                    context: context, // Required for UI rendering
                    initialDate: DateTime.now(), // Default: Today's date
                    firstDate: DateTime(2023, 1, 1), // Min selectable date
                    lastDate: DateTime(2025, 12, 31)); // Max selectable date

                /// **Check if user selected a date**
                if (result != null) {
                  // Format date as "Monday, March 9, 2025"
                  final newDate = DateFormat.MMMMEEEEd().format(result);

                  // Update the text field with formatted date
                  dateController.text = newDate;

                  // Refresh UI to reflect changes
                  setState(() {});
                }
              },
            ),

            SizedBox(height: 20),

            /// Upload Image Button
            /// - Opens a bottom sheet where users can choose between:
            ElevatedButton(
                onPressed: () {
                  /// use function showModalBottomSheet to display image source prompt
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// **Camera Option**
                            ElevatedButton(
                                onPressed: () {
                                  /// call pick image using image source camera
                                  PickImage(ImageSource.camera);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.camera),
                                    SizedBox(width: 20),
                                    Text("Camera"),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                )),

                            /// **Gallery Option**
                            ElevatedButton(
                                onPressed: () {
                                  /// call pick image using image source gallery
                                  PickImage(ImageSource.gallery);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.image),
                                    SizedBox(width: 20),
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
            SizedBox(height: 20),

            /// **Show Selected Image**
            /// - If an image is selected, display it with a **remove button**.
            imagePath != ""
                ? Stack(alignment: Alignment.topRight, children: [
                    /// **Display Image**
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      width: MediaQuery.of(context).size.width * 40 / 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(File(imagePath)),
                      ),
                    ),

                    /// **Remove Image Button**
                    IconButton(
                      onPressed: () {
                        setState(() {
                          imagePath = ""; // Clear image selection
                        });
                      },
                      icon: Icon(Icons.cancel, color: Colors.red),
                    ),
                  ])
                : SizedBox(),
            SizedBox(height: 20),

            /// **Add Task Button**
            /// - Creates a `ToDoItem` object with the entered data.
            /// - Passes the new task **back to the main screen**.
            ElevatedButton(
                onPressed: () {
                  final newItem = ToDoItem(
                      title: titleController.text,
                      isCompleted: false,
                      description: descriptionController.text,
                      imagePath: imagePath != "" ? imagePath : null,
                      date: dateController.text);

                  /// **Return New Task to Previous Page**
                  /// - `Navigator.pop()` sends the `newItem` back to the previous screen (`HomePage`).
                  Navigator.pop(context, newItem);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 10),
                    Text("Add"),
                    SizedBox(width: 30),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
