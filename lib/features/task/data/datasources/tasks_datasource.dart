import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taks_3mc/features/task/data/models/task_model.dart';

abstract class TasksDatasource {
  Future<bool> createTask(TaskModel task);
  Future<List<TaskModel>> getAllTask();
}

class TasksDatasourceImpl implements TasksDatasource {
  final db = FirebaseFirestore.instance;

  @override
  Future<bool> createTask(TaskModel task) async {
    try {
      final docRef = db.collection('tasks').doc();
      var taskToCreate = task;
      taskToCreate.copyWith(id: docRef.id);

      await docRef
          .set(taskToCreate.toMap())
          .then((value) => true, onError: (e) => false);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<TaskModel>> getAllTask() async {
    try {
      List<TaskModel> tasks = [];
      final list = await db.collection("tasks").get();

      for (final doc in list.docs) {
        TaskModel taskmodel = TaskModel.fromMap(doc.data());
        tasks.add(taskmodel);
      }

      return tasks;
    } catch (e) {
      return [];
    }
  }
}
