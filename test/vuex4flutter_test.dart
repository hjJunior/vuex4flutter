import 'package:flutter_test/flutter_test.dart';

import 'package:vuex4flutter/vuex4flutter.dart';

void main() {
  test('adds one to input values', () async {
    final store = Store(
      Module(
        state: { 'oi': true },
        mutations: [
          ChangeOiMutation(),
        ],
        actions: [
          ToggleOiAction(),
        ],
        getters: [
          ToggledOiGetter(),
        ],
        modules: [
          CartModule(),
        ]
      ),
    );

    print(store.state);

    store.commit('ChangeOiMutation', false);

    print(store.state);

    final result = await store.dispatch('ToggleOiAction');

    print(result);

    print(store.state);

    print(store.getter('ToggledOiGetter'));
  });
}

class CartModule extends Module {
  final Map<String, dynamic> state = { 'isFetching': true };
}

class ChangeOiMutation implements Mutation {
  @override
  void call(Map<String, dynamic> state, dynamic payload) {
    state['oi'] = payload;
  }
}

class ToggleOiAction implements Action<Future<String>> {
  @override
  Future<String> call(CommitFn commit, Map<String, dynamic> state, params) {
    commit('ChangeOiMutation', !state['oi']);

    return Future.value('Any value');
  }
}

class ToggledOiGetter implements Getter {
  @override
  bool call(Map<String, dynamic> state) {
    return !state['oi'];
  }
}
