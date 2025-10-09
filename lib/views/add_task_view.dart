import 'package:app_for_adhd/view_models/app_view_model.dart';
import 'package:app_for_adhd/views/bottom_sheets/add_task_bottom_steets_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Stateless widget for the "Add Task" button view.
/// Displays a button that opens a bottom sheet to add a new task.
class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    // UI code: Consumer widget for state management and rebuilding
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return SizedBox(
        height: 60, // UI code: Fixed height for the button
        child: ElevatedButton(
          // UI code: Button styling (background, foreground, shape)
          style: ElevatedButton.styleFrom(
            backgroundColor: viewModel.clrlvl3, // UI code: Button background color
            foregroundColor: viewModel.clrlvl1, // UI code: Icon color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // UI code: Rounded corners
            ),
          ),
          // UI code: Button press action to show bottom sheet
          onPressed: () {
            viewModel.bottomSheetBuilder(const AddTaskBottomSheetView(), context);
          },
          // UI code: Button content (add icon)
          child: Icon(Icons.add, size: 30),
        ),
      );
    });
  }
}