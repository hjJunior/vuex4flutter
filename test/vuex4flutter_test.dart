import 'package:flutter_test/flutter_test.dart';

import 'package:vuex4flutter/vuex4flutter.dart';

void main() {
  test('adds one to input values', () async {
    final store = Store(
      Module(
        modules: [
          CartModule(),
        ]
      ),
    );

    expect(store.getter('/cart/isEmpty'), isTrue);

    await store.dispatch('/cart/FetchCartItemsAction');

    expect(store.getter('/cart/isEmpty'), isFalse);
  });
}

class CartModule extends Module {
  @override
  String get name => 'cart';

  final Map<String, dynamic> state = {
    'fetchingItems': false,
    'items': [],
  };

  final List<Getter> getters = [
    IsCartEmptyGetter(),
  ];

  final List<Mutation> mutations = [
    UpdateCartItemsMutation(),
  ];

  final List<Action> actions = [
    FetchCartItemsAction(),
  ];
}

class IsCartEmptyGetter extends Getter {
  @override
  String get name => 'isEmpty';

  @override
  call({Map<String, dynamic> state, Map<String, dynamic> rootState, getter, rootGetter}) {
    return (state['items'] as List).isEmpty;
  }
}

class UpdateCartItemsMutation extends Mutation {
  @override
  void call(Map<String, dynamic> state, payload) {
    state['items'] = payload;
  }
}

class FetchCartItemsAction extends Action {
  @override
  Future<void> call(CommitFn commit, Map<String, dynamic> state, [dynamic params]) async {
    await Future.delayed(Duration(milliseconds: 300));
    final items = ['fake-item'];

    commit('/cart/UpdateCartItemsMutation', items);
  }
}
