abstract class Mutation {
  String get name => this.runtimeType.toString();
  void call(Map<String, dynamic> state, dynamic payload);
}
