import 'package:vuex4flutter/vuex4flutter.dart';

class MyStore extends Store {
  MyStore()
      : super(
          Module(modules: [
            CartModule(),
          ]),
        );
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
    IsFetchingGetter(),
  ];

  final List<Mutation> mutations = [
    UpdateCartItemsMutation(),
    UpdateFetchingStatusMutation(),
  ];

  final List<Action> actions = [
    FetchCartItemsAction(),
  ];
}

class IsCartEmptyGetter extends Getter {
  @override
  String get name => 'isEmpty';

  @override
  call(
      {Map<String, dynamic> state,
      Map<String, dynamic> rootState,
      getter,
      rootGetter}) {
    return (state['items'] as List).isEmpty;
  }
}

class IsFetchingGetter extends Getter {
  @override
  String get name => 'isFetching';

  @override
  call(
      {Map<String, dynamic> state,
      Map<String, dynamic> rootState,
      getter,
      rootGetter}) {
    return state['fetchingItems'];
  }
}

class UpdateCartItemsMutation extends Mutation {
  @override
  void call(Map<String, dynamic> state, payload) {
    state['items'] = payload;
  }
}

class UpdateFetchingStatusMutation extends Mutation {
  @override
  void call(Map<String, dynamic> state, payload) {
    state['fetchingItems'] = payload;
  }
}

class FetchCartItemsAction extends Action {
  @override
  Future<void> call(CommitFn commit, Map<String, dynamic> state,
      [dynamic params]) async {
    commit('/cart/UpdateFetchingStatusMutation', true);

    await Future.delayed(Duration(milliseconds: 250));
    final items = ['fake-item'];

    commit('/cart/UpdateFetchingStatusMutation', false);
    commit('/cart/UpdateCartItemsMutation', items);
  }
}
