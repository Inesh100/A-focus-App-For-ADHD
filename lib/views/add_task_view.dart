import 'package:app_for_adhd/view_models/app_view_model.dart';
import 'package:app_for_adhd/views/bottom_sheets/add_task_bottom_steets_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return SizedBox(height : 60 , child:ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: viewModel.clrlvl3,
          foregroundColor: viewModel.clrlvl1,
          shape : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      onPressed:(){
        viewModel.bottomSheetBuilder(const AddTaskBottomSheetView(), context);
      }, 
      child: Icon(  Icons.add, size :30)),
      );
      
    },);
  }
}