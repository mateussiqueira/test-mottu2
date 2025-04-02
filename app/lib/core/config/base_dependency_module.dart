import 'package:get_it/get_it.dart';

import 'i_dependency_module.dart';

abstract class BaseDependencyModule implements IDependencyModule {
  final GetIt _getIt;

  BaseDependencyModule(this._getIt);

  GetIt get getIt => _getIt;

  @override
  Future<void> setup(GetIt getIt);
}
