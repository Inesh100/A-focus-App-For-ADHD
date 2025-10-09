import 'package:app_for_adhd/views/task_list_view.dart';
import 'package:flutter/material.dart';

import 'add_task_view.dart';

/// Main To-Do List screen widget.
/// Displays header, task view, task list, and add task button.
class ToDoList extends StatelessWidget {
  const ToDoList ({super.key});

  @override
  Widget build(BuildContext context) {
    // UI code: Scaffold provides the basic visual layout structure
    return Scaffold(
      // UI code: AppBar at the top of the screen
      appBar: AppBar(
        backgroundColor: Colors.transparent, // UI code: AppBar styling
        leading: BackButton(   // UI code: Back arrow button
          onPressed: () {
            Navigator.pop(context); // UI code: navigation action
          },
        ),
      ),
      // UI code: SafeArea to avoid system UI overlap
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // UI code: Header View (red container, placeholder for header)
            Expanded(flex: 1, child: Container(color: Colors.red)),
            // UI code: Task View (green container, placeholder for summary/stats)
            Expanded(flex: 1, child: Container(color: Colors.green)),
            // UI code: Task List View (actual list of tasks)
            Expanded(flex: 7, child: TaskListView()),
          ]
        ),
      ),
      // UI code: Floating action button to add a new task
      floatingActionButton: const AddTaskView(),
    );
  }
}
