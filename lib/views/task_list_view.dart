import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/app_view_model.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child){
      return Container(
        decoration: BoxDecoration(color: viewModel.clrlvl2, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),

        child: ListView.separated
        (padding:EdgeInsets.all(15),
        
        separatorBuilder:(context, index) {
          return SizedBox(height: 15,);
        }, itemCount: viewModel.itemCount,
      
       itemBuilder:(context, index) {
          return Dismissible(
            key:UniqueKey(),
            onDismissed: (Direction){
            viewModel.deleteTask(index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: viewModel.clrlvl1,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                  leading: Checkbox(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    side:BorderSide(width:2 , color: viewModel.clrlvl3),
                    checkColor: viewModel.clrlvl1,
                    activeColor: viewModel.clrlvl3,
                    value:viewModel.getTaskStatus(  index ),
                    onChanged: (value){
                      viewModel.setTaskStatus(index, value!);
                    },
                  ),
                  title:Text(viewModel.getTaskTitle(index), style: TextStyle(
                    color: viewModel.clrlvl4,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    decoration: viewModel.getTaskStatus(index) ? TextDecoration.lineThrough : TextDecoration.none ),),
                  ),
            ),
          );
        }, 
        
      
      ));


    }
    );
      
  }}