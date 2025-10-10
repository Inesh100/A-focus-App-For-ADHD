import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/app_view_model.dart';

/// Stateless widget that displays the list of tasks.
/// Uses Provider to access AppViewModel for state and actions.
class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    // UI code: Consumer widget for state management and rebuilding
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Container(
        // UI code: Container styling (background color, rounded corners)
        decoration: BoxDecoration(
          color: viewModel.clrlvl2,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))
        ),
        // UI code: ListView.separated for displaying tasks with spacing
        child: ListView.separated(
          padding: EdgeInsets.all(15),
          // UI code: Separator widget (SizedBox for spacing)
          separatorBuilder: (context, index) {
            return SizedBox(height: 15);
          },
          itemCount: viewModel.itemCount, // UI code: number of items in the list
          // UI code: Item builder for each task
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(), // UI code: Unique key for swipe-to-dismiss
              onDismissed: (direction) {
                viewModel.deleteTask(index);
              },
              child: Container(
                // UI code: Styling for each task item (background, rounded corners)
                decoration: BoxDecoration(
                  color: viewModel.clrlvl1,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  // UI code: Checkbox for task completion
                  leading: Checkbox(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    side: BorderSide(width: 2, color: viewModel.clrlvl3),
                    checkColor: viewModel.clrlvl1,
                    activeColor: viewModel.clrlvl3,
                    value: viewModel.getTaskStatus(index),
                    onChanged: (value) {
                      viewModel.toggleTaskStatus(index, value!);
                    },
                  ),
                  // UI code: Task title text with styling and strikethrough if completed
                  title: Text(
                    viewModel.getTaskTitle(index),
                    style: TextStyle(
                      color: viewModel.clrlvl4,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      decoration: viewModel.getTaskStatus(index)
                        ? TextDecoration.lineThrough
                        : TextDecoration.none
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}