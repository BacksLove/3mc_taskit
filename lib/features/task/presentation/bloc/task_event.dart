part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskSelectedChanged extends TaskEvent {
  final String task;
  final int type;

  const TaskSelectedChanged({required this.task, required this.type});
}

class AddAPlantEvent extends TaskEvent {}

class RemoveAPlantEvent extends TaskEvent {}

class AddDateEvent extends TaskEvent {
  final DateTime date;

  const AddDateEvent({required this.date});
}

class AddTimeEvent extends TaskEvent {
  final TimeOfDay time;

  const AddTimeEvent({required this.time});
}

class CreateTaskEvent extends TaskEvent {
  final String description;
  final String location;
  final String area;
  final String date;

  const CreateTaskEvent({
    required this.description,
    required this.location,
    required this.area,
    required this.date,
  });
}
