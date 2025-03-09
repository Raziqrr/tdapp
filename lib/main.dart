import 'package:flutter/material.dart';
import 'package:todo_upgrade/views/home_page.dart';

/// The main function is the entry point of every Dart application.
void main() {
  /// `runApp()` starts the Flutter app and displays the given widget.
  /// Here, we pass `MyApp()`, which is the root of the application.
  runApp(const MyApp());
}

/// `MyApp` is the main widget of the application.
class MyApp extends StatelessWidget {
  /// The constructor of `MyApp`. The `super.key` helps Flutter optimize widget rebuilding.
  const MyApp({super.key});

  /// The `build()` method is called whenever Flutter needs to **redraw** the widget.
  /// This happens when:
  /// - The app first starts.
  /// - The parent widget rebuilds (in some cases).
  /// - Hot reload(ctrl+s/lightning button) is used during development.
  ///
  /// However, because `MyApp` extends **StatelessWidget**, it will NOT rebuild
  /// unless the whole app is restarted. If this were a StatefulWidget,
  /// the UI could be updated dynamically based on user interactions.
  ///
  /// Example of a rebuild:
  /// - Imagine a counter app. If `MyApp` were a StatefulWidget, pressing a button
  ///   to increase the count would call `setState()`, causing Flutter to rebuild
  ///   only the part of the screen where the count is displayed.
  /// - Since `MyApp` is Stateless, it does NOT change unless the whole app is restarted.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Removes the debug banner in the top-right corner of the app.
      debugShowCheckedModeBanner: false,

      /// The title of the app, used in places like the task switcher.
      title: 'Flutter Demo',

      ///change based on name of app
      /// The app's theme, which defines colors, styles, and appearance.
      theme: ThemeData(
        /// Defines the primary color scheme of the app.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        /// Enables Material 3 design (the latest version of Google's Material UI).
        useMaterial3: true,

        /// instead of calling background color in every page, can just call once here
        // scaffoldBackgroundColor: Colors.red
      ),

      // The first screen that appears when the app starts.
      home: HomePage(),
    );
  }
}
