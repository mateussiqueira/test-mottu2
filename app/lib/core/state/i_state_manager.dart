abstract class IStateManager<T> {
  T get state;
  void setState(T newState);
  void reset();
  bool get hasState;
}
