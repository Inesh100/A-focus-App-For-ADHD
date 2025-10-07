import 'package:flutter/material.dart';
import '../models/task_models.dart';
import '../models/user_model.dart';



class AppViewModel extends ChangeNotifier {
  List<Task> tasks = <Task>[];
  User user = User('Guest');

  Color clrlvl1 = Colors.grey.shade50;
  Color clrlvl2 = Colors.grey.shade200;
  Color clrlvl3 = Colors.grey.shade800;
  Color clrlvl4 = Colors.grey.shade900;

  int get itemCount => tasks.length;

  void addTask(Task newTask) {
    tasks.add(newTask);
    notifyListeners();
  
  }
  String getTaskTitle(int Taskindex) {
    return tasks[Taskindex].title;
  } 
void deleteTask(int Taskindex) {
    tasks.removeAt(Taskindex);
    notifyListeners();
  }
  bool getTaskStatus(int Taskindex) {
    return tasks[Taskindex].complete;
  }

  void setTaskStatus(int index, bool status) {
    tasks[index].complete = status ;
    notifyListeners();
  }

  void bottomSheetBuilder(Widget bottomSheetView,BuildContext context){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40)),
        clipBehavior: Clip.antiAliasWithSaveLayer,

      context: context, 
      builder:( (context){
      return bottomSheetView;
    }));
  }
}
