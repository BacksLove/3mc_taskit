import 'package:taks_3mc/core/util/network.dart';
import 'package:taks_3mc/features/task/data/datasources/tasks_datasource.dart';
import 'package:taks_3mc/features/task/data/models/task_model.dart';
import 'package:taks_3mc/features/task/domain/repositories/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  NetworkInfo networkInfo;
  TasksDatasource datasource;

  TasksRepositoryImpl(this.networkInfo, this.datasource);

  @override
  Future<bool> createTask(TaskModel task) async {
    await networkInfo.isConnected;

    final createTask = datasource.createTask(task);
    return createTask;
  }

  @override
  Future<List<TaskModel>> getAllTask() async {
    await networkInfo.isConnected;

    final getAllTask = datasource.getAllTask();
    return getAllTask;
  }
}
