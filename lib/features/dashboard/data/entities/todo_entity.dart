import 'package:equatable/equatable.dart';
import 'package:todo_flutter/features/dashboard/presentation/enums/todo_status.dart';

// ignore: must_be_immutable
class TodoEntity extends Equatable {
  String? id;
  String title;
  String description;
  ToDoStatus status;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  TodoEntity(this.title, this.description, this.status);
  @override
  List<Object?> get props => [];
}
