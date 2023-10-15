enum ToDoStatus { TO_DO, IN_PROGRESS, DONE }

extension MethodExtension on ToDoStatus {
  String get value => [
        'To Do',
        'In Progress',
        'Done',
      ][index];

  String getDisplayName() {
    if (this == ToDoStatus.TO_DO) {
      return "To Do";
    } else if (this == ToDoStatus.IN_PROGRESS) {
      return "In Progress";
    } else if (this == ToDoStatus.DONE) {
      return "Done";
    } else {
      return "TO DO";
    }
  }
}
