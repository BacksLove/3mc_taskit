import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:taks_3mc/core/util/network.dart';
import 'package:taks_3mc/features/authentication/data/datasources/authentication_datasource.dart';
import 'package:taks_3mc/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:taks_3mc/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:taks_3mc/features/authentication/domain/usecases/login_with_phone.dart';
import 'package:taks_3mc/features/authentication/domain/usecases/signup_with_phone.dart';
import 'package:taks_3mc/features/authentication/domain/usecases/verify_otp.dart';
import 'package:taks_3mc/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:taks_3mc/features/home/presentation/bloc/home_bloc.dart';
import 'package:taks_3mc/features/map/presentation/bloc/map_bloc.dart';
import 'package:taks_3mc/features/task/data/datasources/tasks_datasource.dart';
import 'package:taks_3mc/features/task/data/repositories/tasks_repository_impl.dart';
import 'package:taks_3mc/features/task/domain/repositories/tasks_repository.dart';
import 'package:taks_3mc/features/task/domain/usecases/create_task.dart';
import 'package:taks_3mc/features/task/domain/usecases/get_all_tasks.dart';
import 'package:taks_3mc/features/task/presentation/bloc/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Authentication
  // Bloc
  sl.registerFactory<AuthenticationBloc>(() => AuthenticationBloc());

  // Datasource
  sl.registerLazySingleton<AuthenticationDatasource>(
      () => AuthenticationDatasourceImpl());

  // Repository
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl(), sl()));

  // Use case
  sl.registerLazySingleton<LoginWithPhone>(() => LoginWithPhone(sl()));
  sl.registerLazySingleton<SignupWithPhone>(() => SignupWithPhone(sl()));
  sl.registerLazySingleton<VerifyOtp>(() => VerifyOtp(sl()));

  //! Home
  // Bloc
  sl.registerFactory<HomeBloc>(() => HomeBloc());

  //! Map
  // Bloc
  sl.registerFactory<MapBloc>(() => MapBloc());

  //! Task
  // Bloc
  sl.registerFactory<TaskBloc>(() => TaskBloc());

  // Datasource
  sl.registerLazySingleton<TasksDatasource>(() => TasksDatasourceImpl());

  // Repository
  sl.registerLazySingleton<TasksRepository>(
      () => TasksRepositoryImpl(sl(), sl()));

  // Use case
  sl.registerLazySingleton<GetAllTasks>(() => GetAllTasks(sl()));
  sl.registerLazySingleton<CreateTask>(() => CreateTask(sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
}
