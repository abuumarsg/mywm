import 'package:get_it/get_it.dart';
import 'ui/data_provider.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<DataProvider>(() {
    return DataProvider()..fetchData();
  });
}