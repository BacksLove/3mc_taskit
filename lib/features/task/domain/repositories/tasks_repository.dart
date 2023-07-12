import 'package:taks_3mc/features/task/data/models/task_model.dart';

abstract class TasksRepository {
  Future<bool> createTask(TaskModel task);
  Future<List<TaskModel>> getAllTask();
}
