import 'package:get/get.dart';

import 'i_state_manager.dart';

class GetXStateManager<T> implements IStateManager<T> {
  final Rx<T> _state;
  final T _initialState;

  GetXStateManager(this._initialState) : _state = _initialState.obs;

  @override
  T get state => _state.value;

  @override
  void setState(T newState) {
    _state.value = newState;
  }

  @override
  void reset() {
    _state.value = _initialState;
  }

  @override
  bool get hasState => _state.value != _initialState;
}
