library vuex4flutter;

import 'package:rxdart/rxdart.dart';
import './types/index.dart';
export './types/index.dart';

class Store {
  Map<String, Action> _actions = {};
  Map<String, Getter> _getters = {};
  Map<String, Mutation> _mutations = {};
  Map<String, dynamic> _state = {};
  BehaviorSubject _stateSubject;

  Store(Module module) {
    assert(module != null, 'State must be at least an empty object');
    registerModule(module);
  }

  Map<String, dynamic> get state => _state['/'];

  T getter<T>(String getterPath) {
    assert(_getters.containsKey(getterPath), '[vuex4flutter] unknown getter: $getterPath');
    final getterFn = _getters[getterPath];

    return getterFn(state);
  }

  void commit(String mutation, [dynamic params]) {
    assert(_mutations.containsKey(mutation), '[vuex4flutter] unknown mutation type: $mutation');
    final mutationFn = _mutations[mutation];

    mutationFn(state, params);
  }

  T dispatch<T>(String action, [dynamic params]) {
    assert(_actions.containsKey(action), '[vuex4flutter] unknown action type: $action');
    final actionFn = _actions[action];

    return actionFn(this.commit, state, params);
  }

  void closeSubscription() {
    if (!(_stateSubject?.isClosed ?? true)) {
      _stateSubject.close();
    }
  }

  void registerModule(Module module, [String namespace = '']) {
    _state[namespace == '' ? '/' : namespace ] = module.state;
    _registerProperties(module.mutations, on: _mutations, namespace: namespace);
    _registerProperties(module.actions, on: _actions, namespace: namespace);
    _registerProperties(module.getters, on: _getters, namespace: namespace);

    if (module.modules == null || module.modules.isEmpty) {
      return;
    }

    module.modules.forEach((module) {
      final nextNamespace = '$namespace/${module.namespace}';

      registerModule(module, nextNamespace);
    });
  }

  void _registerProperties(List properties, {Map on, String namespace = '' }) {
    properties?.forEach((property) {
      final key = '$namespace${property.runtimeType.toString()}';

      on[key] = property;
    });
  }
}

