import 'package:rxdart/rxdart.dart';

import './types/index.dart';

class Store {
  Map<String, Action> _actions = {};
  Map<String, Getter> _getters = {};
  Map<String, Mutation> _mutations = {};
  Map<String, dynamic> _state = {};

  final _stateSubject = BehaviorSubject<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get state => _stateSubject.stream;

  Store(Module module) {
    assert(module != null, '[vuex4flutter] You must have at least one root module');
    registerModule(module);
  }

  T getter<T>(String getterPath) {
    assert(_getters.containsKey(getterPath), '[vuex4flutter] unknown getter: $getterPath');
    final getterFn = _getters[getterPath];
    final module = _modulePathFor(getterPath);

    final localGetter = (String getter) {
      final normalizedModule = module.split('//').skip(1).join();

      return this.getter('$normalizedModule$getter');
    };

    return getterFn(
      state: _state[module],
      rootState: _state,
      getter: localGetter,
      rootGetter: this.getter,
    );
  }

  void commit(String mutation, [dynamic params]) {
    assert(_mutations.containsKey(mutation), '[vuex4flutter] unknown mutation type: $mutation');
    final mutationFn = _mutations[mutation];
    final module = _modulePathFor(mutation);

    mutationFn(_state[module], params);

    _stateSubject.add(_state);
  }

  T dispatch<T>(String action, [dynamic params]) {
    assert(_actions.containsKey(action), '[vuex4flutter] unknown action type: $action');
    final actionFn = _actions[action];

    return actionFn(this.commit, _state, params);
  }

  void registerModule(Module module, [String namespace = '']) {
    _state[namespace == '' ? '/' : namespace ] = module.state;
    _registerProperties(module.mutations, on: _mutations, namespace: namespace);
    _registerProperties(module.actions, on: _actions, namespace: namespace);
    _registerProperties(module.getters, on: _getters, namespace: namespace);

    _stateSubject.add(_state);

    if (module.modules == null || module.modules.isEmpty) {
      return;
    }

    module.modules.forEach((module) {
      final nextNamespace = '$namespace/${module.name}';

      registerModule(module, nextNamespace);
    });
  }

  void _registerProperties(List properties, {Map on, String namespace = '' }) {
    properties?.forEach((property) {
      final key = '$namespace/${property.name}';

      on[key] = property;
    });
  }

  String _modulePathFor(String property) {
    final path = property.split('/').skip(1);
    final module = '/' + path.take(1).take(path.length - 1).join('/');

    return module;
  }
}
