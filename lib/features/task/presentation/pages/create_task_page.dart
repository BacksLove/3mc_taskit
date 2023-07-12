import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taks_3mc/core/component/textfield.dart';
import 'package:taks_3mc/core/constants/enums/tasks_enum.dart';
import 'package:taks_3mc/core/constants/images.dart';
import 'package:taks_3mc/core/constants/localized.dart';

import 'package:taks_3mc/core/constants/size.dart';
import 'package:taks_3mc/core/constants/spacer.dart';
import 'package:taks_3mc/core/route/routes.dart';
import 'package:taks_3mc/core/util/snackbar.dart';
import 'package:taks_3mc/features/task/presentation/bloc/bloc.dart';

import 'package:taks_3mc/injection_container.dart' as di;

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = <String>[
      localized(context).rackingLeaves,
      localized(context).trimming,
      localized(context).wateringPlants,
    ];

    TextEditingController locationController = TextEditingController();
    TextEditingController areaController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    final taskBloc = di.sl<TaskBloc>();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => taskBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(localized(context).createTask),
        ),
        body: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state.status == TaskStatus.taskCreate) {
              Navigator.pushReplacementNamed(context, homePage);
            } else if (state.status == TaskStatus.emptyField) {
              showFloatingFlushbar(
                  context, null, localized(context).fieldEmpty);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(screenPaddingSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: DropdownButton<String>(
                      value: state.taskSelected.isEmpty
                          ? null
                          : state.taskSelected,
                      elevation: 15,
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? value) {
                        taskBloc.add(TaskSelectedChanged(
                            task: value!, type: list.indexOf(value) + 1));
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: textTheme.bodyMedium,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  vSpace15,
                  if (state.taskSelected.isEmpty) ...{
                    Image.asset(authScreenImage),
                    vSpace30,
                    Text(localized(context).selectCategoryFirst),
                  } else ...{
                    Text(localized(context).location),
                    vSpace10,
                    CustomTextField(controller: locationController),
                    vSpace20,
                    if (state.taskSelected ==
                        localized(context).rackingLeaves) ...{
                      Text(localized(context).areCoverage),
                      vSpace10,
                      CustomTextField(
                        controller: areaController,
                        hint: localized(context).areCoverage,
                      ),
                    } else ...{
                      Text(
                        localized(context).numberOfPlants,
                      ),
                      vSpace10,
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              taskBloc.add(RemoveAPlantEvent());
                            },
                            child: const Text("-"),
                          ),
                          hSpace20,
                          Text(state.numberOfPlant.toString()),
                          hSpace20,
                          ElevatedButton(
                            onPressed: () {
                              taskBloc.add(AddAPlantEvent());
                            },
                            child: const Text("+"),
                          ),
                        ],
                      )
                    },
                    vSpace20,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(localized(context).date),
                              vSpace10,
                              DateTimePicker(
                                controller: dateController,
                                isDate: true,
                                function: (value) {
                                  taskBloc.add(AddDateEvent(date: value));
                                },
                              )
                            ],
                          ),
                        ),
                        hSpace20,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(localized(context).time),
                              vSpace10,
                              DateTimePicker(
                                  controller: timeController,
                                  isDate: false,
                                  function: (value) {
                                    taskBloc.add(AddTimeEvent(time: value));
                                  })
                            ],
                          ),
                        )
                      ],
                    ),
                    vSpace25,
                    Text(localized(context).description),
                    vSpace10,
                    CustomTextField(
                      controller: descriptionController,
                      hint: localized(context).description,
                      multiline: true,
                    ),
                    vSpace80,
                    ElevatedButton(
                      onPressed: () {
                        taskBloc.add(
                          CreateTaskEvent(
                            description: descriptionController.text,
                            location: locationController.text,
                            area: areaController.text.isEmpty
                                ? "0"
                                : areaController.text,
                            date:
                                "${dateController.text} ${timeController.text}",
                          ),
                        );
                      },
                      child: Text(localized(context).bookNow),
                    ),
                    vSpace40,
                  },
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
