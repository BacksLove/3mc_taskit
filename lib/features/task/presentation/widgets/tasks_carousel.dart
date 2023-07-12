import 'package:flutter/material.dart';
import 'package:taks_3mc/core/constants/localized.dart';
import 'package:taks_3mc/core/constants/spacer.dart';
import 'package:taks_3mc/core/util/date.dart';
import 'package:taks_3mc/features/task/data/models/task_model.dart';

class TaskCarousel extends StatelessWidget {
  const TaskCarousel({super.key, required this.tasks});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tasks.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TaskCard(
              task: tasks[index],
            ),
          );
        },
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(task.getImageFromType()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          hSpace15,
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                vSpace20,
                Text(
                  task.getNameFromType(context),
                  style: textTheme.headlineMedium,
                ),
                vSpace10,
                Text(
                  task.location,
                  style: textTheme.bodySmall,
                ),
                Text(
                  dateToString(task.date),
                  style: textTheme.bodySmall,
                ),
                vSpace10,
                Text(
                  task.description,
                  style: textTheme.bodyMedium,
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(localized(context).accept),
                  ),
                ),
                vSpace10,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
