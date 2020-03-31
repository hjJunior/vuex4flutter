typedef CommitFn<T> = void Function(String mutation, [T params]);

abstract class Action<T> {
  T call(CommitFn commit, Map<String, dynamic> state, dynamic params);
}