import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taks_3mc/core/util/locations.dart';
import 'package:taks_3mc/features/task/data/models/task_model.dart';
import 'package:taks_3mc/features/task/domain/usecases/get_all_tasks.dart';

import 'package:taks_3mc/injection_container.dart' as di;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeInitEvent>(_onStart);
  }

  FutureOr<void> _onStart(HomeInitEvent event, Emitter<HomeState> emit) async {
    final userPosition = await getCurrentLocation();

    final userAdress = await getAdressFromLatLong(
        userPosition.latitude, userPosition.longitude);
    final userAdressFormatted = addressFormatter(userAdress);

    final tasks = await di.sl<GetAllTasks>().call(NoParams());
    final sortedTasks = await sortTasksByDistance(tasks);

    emit(state.copyWith(userLocation: userAdressFormatted, tasks: sortedTasks));
  }
}
