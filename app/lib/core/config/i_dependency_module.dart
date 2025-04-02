import 'package:get_it/get_it.dart';

abstract class IDependencyModule {
  Future<void> setup(GetIt getIt);
}
