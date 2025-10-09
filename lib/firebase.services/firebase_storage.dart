import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_models.dart';

/// Service class to interact with Firebase Firestore for task management.
class FirebaseStorageService {
  // Instance of Firestore database.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Constructor: Enables offline persistence for Firestore.
  FirebaseStorageService() {
    // Enable offline data caching so the app works without internet.
    _firestore.settings = const Settings(persistenceEnabled: true);
  }

  /// Test Firestore connection by attempting to read a test document.
  /// Prints result to console.
  Future<void> testConnection() async {
    try {
      // Try to get a document from 'users/testUser'.
      await _firestore.collection('users').doc('testUser').get();
      print('✅ Firestore connection successful!');
    } catch (e) {
      // Print error if connection fails.
      print('❌ Firestore connection failed: $e');
    }
  }

  /// Returns a reference to the 'tasks' subcollection for a specific user.
  /// [userId] - The ID of the user whose tasks are being accessed.
  CollectionReference<Map<String, dynamic>> tasksRef(String userId) {
    // Navigates to users/{userId}/tasks collection.
    return _firestore.collection('users').doc(userId).collection('tasks');
  }

  /// Loads all tasks for a given user from Firestore.
  /// Returns a list of Task objects.
  Future<List<Task>> loadTasks(String userId) async {
    // Fetch all documents in the user's tasks collection.
    final snapshot = await tasksRef(userId).get();
    // Map each document to a Task object.
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Task(
        data['title'] ?? '',      // Task title, default empty string.
        data['complete'] ?? false // Task completion status, default false.
      );
    }).toList();
  }

  /// Adds a new task to the user's tasks collection in Firestore.
  /// [task] - The Task object to add.
  /// [userId] - The ID of the user.
  Future<void> addTask(Task task, String userId) async {
    // Add a new document with task data.
    await tasksRef(userId).add({
      'title': task.title,
      'complete': task.complete,
    });
  }

  /// Deletes a specific task document from Firestore.
  /// [docRef] - Reference to the document to delete.
  Future<void> deleteTask(DocumentReference docRef) async {
    // Remove the document from Firestore.
    await docRef.delete();
  }

  /// Updates an existing task document in Firestore.
  /// [docRef] - Reference to the document to update.
  /// [task] - The updated Task object.
  Future<void> updateTask(DocumentReference docRef, Task task) async {
    // Update the document fields with new task data.
    await docRef.update({
      'title': task.title,
      'complete': task.complete,
    });
  }

  /// Listens to real-time updates of the user's tasks collection.
  /// Returns a stream of lists containing task data and document references.
  Stream<List<Map<String, dynamic>>> streamTasks(String userId) {
    // Listen to changes in the tasks collection.
    return tasksRef(userId).snapshots().map((snapshot) {
      // Map each document to a map with its reference and Task object.
      return snapshot.docs.map((doc) => {
        'docRef': doc.reference,                  // Document reference for updates/deletes.
        'task': Task(doc['title'], doc['complete']), // Task object from document data.
      }).toList();
    });
  }
}
