import './index.dart';

class Module {
  String get name => this.runtimeType.toString();

  final Map<String, dynamic> state;
  final List<Mutation> mutations;
  final List<Action> actions;
  final List<Getter> getters;
  final List<Module> modules;

  Module({
    this.state = const {},
    this.mutations = const [],
    this.actions = const [],
    this.getters = const [],
    this.modules = const [],
  });
}
