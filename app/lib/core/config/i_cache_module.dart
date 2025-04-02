import 'package:get_it/get_it.dart';

abstract class ICacheModule {
  Future<void> setup(GetIt getIt);
}
