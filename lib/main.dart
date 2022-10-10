import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter_etiqa/todo_list/view_models/todo_view_models.dart';
import 'package:todo_list_flutter_etiqa/todo_list/views/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoViewModels())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}


