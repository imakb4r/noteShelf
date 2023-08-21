import 'package:flutter/material.dart';
import 'package:note_shelf/src/res/appStrings.dart';
import 'package:note_shelf/src/views/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      home: HomeView(),
    );
  }
}
