import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:taks_3mc/core/constants/enums/tasks_enum.dart';
import 'package:taks_3mc/features/task/data/models/task_model.dart';
import 'package:taks_3mc/features/task/domain/usecases/create_task.dart';

import 'package:taks_3mc/injection_container.dart' as di;

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState.initial()) {
    on<TaskSelectedChanged>(_onTaskChanged);
    on<AddAPlantEvent>(_onAddPlant);
    on<RemoveAPlantEvent>(_onRemovePlant);
    on<AddDateEvent>(_onAddDate);
    on<AddTimeEvent>(_onAddTime);
    on<CreateTaskEvent>(_onCreateTask);
  }

  FutureOr<void> _onTaskChanged(
      TaskSelectedChanged event, Emitter<TaskState> emit) {
    if (event.task.isNotEmpty) {
      emit(
        state.copyWith(
            taskSelected: event.task,
            type: event.type,
            status: TaskStatus.initial),
      );
    }
  }

  FutureOr<void> _onAddPlant(AddAPlantEvent event, Emitter<TaskState> emit) {
    emit(state.copyWith(
        numberOfPlant: state.numberOfPlant + 1, status: TaskStatus.initial));
  }

  FutureOr<void> _onRemovePlant(
      RemoveAPlantEvent event, Emitter<TaskState> emit) {
    if (state.numberOfPlant > 0) {
      emit(state.copyWith(
          numberOfPlant: state.numberOfPlant - 1, status: TaskStatus.initial));
    }
  }

  FutureOr<void> _onCreateTask(
      CreateTaskEvent event, Emitter<TaskState> emit) async {
    DateTime date = DateTime(
      state.date.year,
      state.date.month,
      state.date.day,
      state.time.hour,
      state.time.minute,
    );

    if (event.location.isEmpty || event.description.isEmpty) {
      emit(state.copyWith(status: TaskStatus.emptyField));
    } else {
      final coordinate =
          await GeocodingPlatform.instance.locationFromAddress(event.location);
      final TaskModel task = TaskModel(
          id: "",
          type: state.type,
          location: event.location,
          date: date,
          latitude: coordinate.first.latitude,
          longitude: coordinate.first.longitude,
          description: event.description,
          numberPlants: state.numberOfPlant,
          areacoverage: int.parse(event.area));

      await di.sl<CreateTask>().call(CreateTaskParams(task: task));
      emit(state.copyWith(status: TaskStatus.taskCreate));
    }
  }

  FutureOr<void> _onAddDate(AddDateEvent event, Emitter<TaskState> emit) {
    emit(state.copyWith(date: event.date, status: TaskStatus.initial));
  }

  FutureOr<void> _onAddTime(AddTimeEvent event, Emitter<TaskState> emit) {
    emit(state.copyWith(time: event.time, status: TaskStatus.initial));
  }
}
