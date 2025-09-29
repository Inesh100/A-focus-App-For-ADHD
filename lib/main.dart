git remote add originimport 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/to_do_list.dart';
import 'view_models/app_view_model.dart'; // Make sure the file name matches exactly

void main() {
  runApp(ChangeNotifierProvider(create:(context) => AppViewModel(),  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clarity',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clarity'),
      centerTitle: true),
      body: Center(
        child: ElevatedButton(
          child: Text('Tasks'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>ToDoList()),
            );
          },
        ),
      ),
    );
  }
}
