part of 'task_bloc.dart';

class TaskState extends Equatable {
  final TaskStatus status;
  final String taskSelected;
  final DateTime date;
  final TimeOfDay time;
  final int type;
  final int numberOfPlant;

  const TaskState(
      {required this.status,
      required this.taskSelected,
      required this.numberOfPlant,
      required this.date,
      required this.time,
      required this.type});

  factory TaskState.initial() => TaskState(
      status: TaskStatus.initial,
      taskSelected: "",
      numberOfPlant: 0,
      type: 0,
      date: DateTime.now(),
      time: TimeOfDay.now());

  @override
  List<Object> get props => [status, numberOfPlant, type, date, time];

  TaskState copyWith({
    TaskStatus? status,
    String? taskSelected,
    DateTime? date,
    TimeOfDay? time,
    int? numberOfPlant,
    int? type,
  }) {
    return TaskState(
      status: status ?? this.status,
      taskSelected: taskSelected ?? this.taskSelected,
      date: date ?? this.date,
      time: time ?? this.time,
      numberOfPlant: numberOfPlant ?? this.numberOfPlant,
      type: type ?? this.type,
    );
  }
}
