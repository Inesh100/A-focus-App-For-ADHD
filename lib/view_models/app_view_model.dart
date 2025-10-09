import 'package:flutter/material.dart';
import '../firebase.services/firebase_storage.dart';
import '../models/task_models.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// ViewModel for managing app state, user, and tasks.
/// Uses ChangeNotifier for state updates in Flutter.
class AppViewModel extends ChangeNotifier {
  User? user;                    // Current user object.
  List<Task> tasks = [];         // List of Task objects for the user.
  List<DocumentReference> taskRefs = []; // List of Firestore document references for each task.

  // Service for interacting with Firebase Firestore.
  final FirebaseStorageService _firebaseService = FirebaseStorageService();

  /// Constructor: Tests Firestore connection on initialization.
  AppViewModel() {
    // Test connection when ViewModel initializes
    _firebaseService.testConnection();
  }

  // 🎨 App colors for UI theming.
  final Color clrlvl1 = Colors.grey.shade50;
  final Color clrlvl2 = Colors.grey.shade200;
  final Color clrlvl3 = Colors.grey.shade800;
  final Color clrlvl4 = Colors.grey.shade900;

  /// Returns the number of tasks.
  int get itemCount => tasks.length;

  /// Sets the current user and loads/listens to their tasks.
  /// [currentUser] - The user to set as active.
  void setUser(User currentUser) {
    user = currentUser;
    loadTasks();      // Load tasks once.
    listenToTasks();  // Start listening for real-time updates.
  }

  /// Loads all tasks for the current user from Firestore (one-time).
  Future<void> loadTasks() async {
    if (user == null) return;
    tasks = await _firebaseService.loadTasks(user!.username);
    notifyListeners(); // Notify UI of changes.
  }

  /// Listens for real-time updates to the user's tasks collection.
  /// Updates tasks and their document references on change.
  void listenToTasks() {
    if (user == null) return;
    _firebaseService.streamTasks(user!.username).listen((list) {
      tasks.clear();
      taskRefs.clear();

      // For each item, add the Task object and its document reference.
      for (var item in list) {
        tasks.add(item['task']);
        taskRefs.add(item['docRef']);
      }

      notifyListeners(); // Notify UI of changes.
    });
  }

  /// Adds a new task for the current user.
  /// [task] - The Task object to add.
  Future<void> addTask(Task task) async {
    if (user == null) return;
    await _firebaseService.addTask(task, user!.username);
  }

  /// Deletes a task at the given index.
  /// [index] - Index of the task to delete.
  Future<void> deleteTask(int index) async {
    if (user == null || index >= taskRefs.length) return;
    await _firebaseService.deleteTask(taskRefs[index]);
  }

  /// Toggles the completion status of a task at the given index.
  /// [index] - Index of the task to toggle.
  Future<void> toggleTaskStatus(int index) async {
    if (user == null || index >= taskRefs.length) return;
    tasks[index].complete = !tasks[index].complete;
    await _firebaseService.updateTask(taskRefs[index], tasks[index]);
  }

  /// Returns the title of the task at the given index.
  String getTaskTitle(int index) => tasks[index].title;

  /// Returns the completion status of the task at the given index.
  bool getTaskStatus(int index) => tasks[index].complete;

  /// Builds and shows a reusable bottom sheet in the app.
  /// [bottomSheetView] - The widget to display in the bottom sheet.
  /// [context] - BuildContext for showing the sheet.
  void bottomSheetBuilder(Widget bottomSheetView, BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)), // UI code: bottom sheet shape
      clipBehavior: Clip.antiAliasWithSaveLayer, // UI code: bottom sheet clipping
      context: context,
      builder: (context) => bottomSheetView, // UI code: widget builder for bottom sheet
    );
  }
}
