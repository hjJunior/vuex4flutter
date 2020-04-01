typedef CommitFn<T> = void Function(String mutation, [T params]);

abstract class Action<T> {
  String get name => this.runtimeType.toString();
  T call(CommitFn commit, Map<String, dynamic> state, dynamic params);
}
