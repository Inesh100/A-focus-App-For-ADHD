import 'package:app_for_adhd/view_models/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/task_models.dart';

/// Stateless widget for the bottom sheet to add a new task.
class AddTaskBottomSheetView extends StatelessWidget {
  const AddTaskBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller for the text field input.
    final TextEditingController entryController = TextEditingController();

    // Use Consumer to access AppViewModel from Provider.
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Padding(
        // Adjust padding for keyboard overlay.
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 80, // Fixed height for the bottom sheet.
          child : 
          Center(
            child: SizedBox(
              height: 40,
              width: 250,
              // TextField for entering the new task title.
              child: TextField(
                // When user submits (presses enter), add the task.
                onSubmitted: (value){
                  if(entryController.text.isNotEmpty){
                    // Create a new Task object with the entered text.
                    Task newTask = Task(entryController.text,false);
                    // Add the new task using the ViewModel.
                    viewModel.addTask(newTask);
                    // Clear the text field after adding.
                    entryController.clear();
                  }
                  // Close the bottom sheet after submission.
                  Navigator.of(context).pop();
                },
                // Input decoration for styling the text field.
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 5),
                  filled: true,
                  fillColor: viewModel.clrlvl2, // Use ViewModel color for background.
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                  )
                ),
                autofocus: true, // Focus the field when sheet opens.
                textAlign: TextAlign.center, // Center the text horizontally.
                textAlignVertical: TextAlignVertical.center, // Center the text vertically.
                cursorColor: viewModel.clrlvl4, // Use ViewModel color for cursor.
                style:TextStyle(
                  color: viewModel.clrlvl4,
                  fontWeight: FontWeight.w500,
                  fontSize: 20
                ),
                controller: entryController, // Attach controller to field.
              ),
            ),
          )
        ),
      );
    },);
  }
}