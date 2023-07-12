import 'package:flutter_test/flutter_test.dart';
import 'package:taks_3mc/core/constants/enums/tasks_enum.dart';
import 'package:taks_3mc/features/task/presentation/bloc/bloc.dart';

void main() {
  late TaskBloc taskBloc;

  setUp(() {
    taskBloc = TaskBloc();
  });

  test(
    "Le status du bloc à l'initialisation doit etre sur initial",
    () => {
      // assert
      expect(taskBloc.state.status, TaskStatus.initial)
    },
  );
}
