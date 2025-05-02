import 'package:get_it/get_it.dart';
import '../../data/repositories/contact_repository.dart';
import '../../domain/usecases/contact_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ContactRepository());
  locator.registerLazySingleton(() => ContactService(locator()));
}