part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String userLocation;
  final List<TaskModel> tasks;

  const HomeState({required this.userLocation, required this.tasks});

  factory HomeState.initial() => const HomeState(userLocation: "", tasks: []);

  @override
  List<Object> get props => [userLocation, tasks];

  HomeState copyWith({
    String? userLocation,
    List<TaskModel>? tasks,
  }) {
    return HomeState(
      userLocation: userLocation ?? this.userLocation,
      tasks: tasks ?? this.tasks,
    );
  }
}
