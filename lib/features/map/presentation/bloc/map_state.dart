// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'map_bloc.dart';

class MapState extends Equatable {
  final List<TaskModel> tasks;
  final List<LatLng> points;

  const MapState({required this.tasks, required this.points});

  factory MapState.initial() => const MapState(tasks: [], points: []);

  @override
  List<Object> get props => [tasks, points];

  MapState copyWith({
    List<TaskModel>? tasks,
    List<LatLng>? points,
  }) {
    return MapState(
      tasks: tasks ?? this.tasks,
      points: points ?? this.points,
    );
  }
}
