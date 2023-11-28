import 'package:flutter/material.dart';
import 'package:todo_clean_archi/src/features/todo/presentation/todo_page.dart';
import 'package:todo_clean_archi/src/utils/tools_functions.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocusKeyboard(context),
      child: MaterialApp(
        title: "todo clean",
        home: TodoPage(),
      ),
    );
  }
}