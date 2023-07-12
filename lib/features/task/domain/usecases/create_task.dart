import 'package:equatable/equatable.dart';
import 'package:taks_3mc/core/usecases/usecase.dart';
import 'package:taks_3mc/features/task/data/models/task_model.dart';
import 'package:taks_3mc/features/task/domain/repositories/tasks_repository.dart';

class CreateTask extends UseCase<bool, CreateTaskParams> {
  final TasksRepository repository;

  CreateTask(this.repository);

  @override
  Future<bool> call(CreateTaskParams params) async {
    return await repository.createTask(params.task);
  }
}

class CreateTaskParams extends Equatable {
  final TaskModel task;

  const CreateTaskParams({required this.task});

  @override
  List<Object?> get props => [task];
}
