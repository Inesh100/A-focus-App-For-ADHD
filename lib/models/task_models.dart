/// Represents a single task item, typically stored in Firestore.
class Task {
  String id;        // Unique identifier for the task document (useful for updates/deletes).
  String title;     // The title or description of the task.
  bool complete;    // Whether the task is completed.

  /// Constructor for Task.
  /// [title] - The name or description of the task.
  /// [complete] - Completion status.
  /// [id] - Optional document ID (default is empty string).
  Task(this.title, this.complete, {this.id = ''});

  /// Converts the Task object into a Map for Firestore storage.
  /// Only includes title and complete fields (not id).
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'complete': complete,
    };
  }

  /// Factory constructor to create a Task object from Firestore data.
  /// [data] - Map containing task fields from Firestore.
  /// [id] - Optional document ID.
  factory Task.fromMap(Map<String, dynamic> data, {String id = ''}) {
    return Task(
      data['title'] ?? '',        // Use empty string if title is missing.
      data['complete'] ?? false,  // Use false if complete is missing.
      id: id,                     // Assign provided id.
    );
  }
}
