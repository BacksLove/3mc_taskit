import 'package:taks_3mc/core/usecases/usecase.dart';
import 'package:taks_3mc/features/task/data/models/task_model.dart';
import 'package:taks_3mc/features/task/domain/repositories/tasks_repository.dart';

class GetAllTasks extends UseCase<List<TaskModel>, NoParams> {
  final TasksRepository repository;

  GetAllTasks(this.repository);

  @override
  Future<List<TaskModel>> call(NoParams params) async {
    return await repository.getAllTask();
  }
}

class NoParams {}
