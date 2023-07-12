import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taks_3mc/core/util/network.dart';
import 'package:taks_3mc/features/task/data/datasources/tasks_datasource.dart';
import 'package:taks_3mc/features/task/data/repositories/tasks_repository_impl.dart';
import 'package:taks_3mc/features/task/domain/repositories/tasks_repository.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockTaskDatasource extends Mock implements TasksDatasource {}

void main() {
  late TasksRepository repository;
  late MockNetworkInfo mockNetworkInfo;
  late MockTaskDatasource mockTaskDatasource;

  setUp(() {
    mockTaskDatasource = MockTaskDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TasksRepositoryImpl(mockNetworkInfo, mockTaskDatasource);
  });

  test('check if the device is online', () async {
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    // act
    await repository.getAllTask();
    // assert
    verify(mockNetworkInfo.isConnected);
  });
}
