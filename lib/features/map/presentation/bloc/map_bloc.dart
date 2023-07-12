import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:taks_3mc/core/util/locations.dart';
import 'package:taks_3mc/features/task/data/models/task_model.dart';
import 'package:taks_3mc/features/task/domain/usecases/get_all_tasks.dart';

import 'package:taks_3mc/injection_container.dart' as di;

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState.initial()) {
    on<MapLaunchedEvent>(_onMapLaunched);
  }

  FutureOr<void> _onMapLaunched(
      MapLaunchedEvent event, Emitter<MapState> emit) async {
    final tasks = await di.sl<GetAllTasks>().call(NoParams());
    List<LatLng> points = [];
    if (tasks.isNotEmpty) {
      for (final point in tasks) {
        final geoCoordinates = await GeocodingPlatform.instance
            .locationFromAddress(point.location);
        final latlong = LatLng(
            geoCoordinates.first.latitude, geoCoordinates.first.longitude);
        points.add(latlong);
      }
    }
    final sortedTasks = await sortTasksByDistance(tasks);
    emit(state.copyWith(tasks: sortedTasks, points: points));
  }
}
