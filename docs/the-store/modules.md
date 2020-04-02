# Modules

## Defining a module

{% tabs %}
{% tab title="Module" %}
```dart
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
```
{% endtab %}

{% tab title="Getters" %}
```dart
class IsCartEmptyGetter extends Getter {
  @override
  String get name => 'isEmpty';

  @override
  call({Map<String, dynamic> state, Map<String, dynamic> rootState, getter, rootGetter}) {
    return (state['items'] as List).isEmpty;
  }
}

class IsFetchingGetter extends Getter {
  @override
  String get name => 'isFetching';

  @override
  call({Map<String, dynamic> state, Map<String, dynamic> rootState, getter, rootGetter}) {
    return state['fetchingItems'];
  }
}
```
{% endtab %}

{% tab title="Mutations" %}
```dart
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
```
{% endtab %}

{% tab title="Actions" %}
```dart
class FetchCartItemsAction extends Action {
  @override
  Future<void> call(CommitFn commit, Map<String, dynamic> state, [dynamic params]) async {
    commit('/cart/UpdateFetchingStatusMutation', true);

    await Future.delayed(Duration(milliseconds: 250));
    final items = ['fake-item'];

    commit('/cart/UpdateFetchingStatusMutation', false);
    commit('/cart/UpdateCartItemsMutation', items);
  }
}
```
{% endtab %}
{% endtabs %}

## Registering the module

```dart
class MyStore extends Store {
  MyStore() : super(
    Module(
      modules: [
        CartModule(),
      ]
    ),
  );
}
```

## Using features from the module

All the features can be used as quite as the previously ones, the unique difference now, is that you need to pass the namespace as prefix. Your namespace will be the path for your module

{% tabs %}
{% tab title="Getter" %}
```dart
store.getter('/cart/isEmpty');
```
{% endtab %}

{% tab title="Commit" %}
```dart
store.commit('/cart/UpdateCartItemsMutation');
```
{% endtab %}

{% tab title="Dispatch" %}
```dart
store.dispatch('/cart/FetchCartItemsAction');
```
{% endtab %}
{% endtabs %}
