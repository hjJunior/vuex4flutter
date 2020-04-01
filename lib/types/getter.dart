typedef GetterFn<T> = T Function(String getterPath);

abstract class Getter<T> {
  String get name => this.runtimeType.toString();

  T call({
    Map<String, dynamic> state,
    Map<String, dynamic> rootState,
    GetterFn getter,
    GetterFn rootGetter,
  });
}
