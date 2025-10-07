import 'package:app_for_adhd/views/task_list_view.dart';
import 'package:flutter/material.dart';

import 'add_task_view.dart';

class ToDoList extends StatelessWidget {
  const ToDoList ({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(   // 👈 This gives you the back arrow
          onPressed: () {
            Navigator.pop(context); // 👈 Returns to HomePage
          },
        ),
      ),
      body : SafeArea(
        // uncomment lines 9, 11,20 to streach the app to fully envelop the top
       //top : false,
        bottom : false,
        child: Column(
          children : [
            //Hedder View
            Expanded(flex :1,child:Container(color :Colors.red),),
            //Task View
            Expanded(flex :1,child:Container(color :Colors.green),),
            //Task List View
            Expanded(flex :7,child:TaskListView()),
          ]
        ),
     ),
      floatingActionButton: const AddTaskView(),
    );
  }
}
