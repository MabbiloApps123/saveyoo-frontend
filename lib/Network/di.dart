import 'package:get_it/get_it.dart';
import 'package:saveyoo/Network/my_dio.dart';
import 'package:saveyoo/Utils/pref_manager.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<MyDio>(
    () => MyDio(),
  );
  sl.registerLazySingleton<StorageService>(
    () => StorageService(),
  );
}
