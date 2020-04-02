# Actions

## Defining the action

```dart
class RevertMessageAction extends Action {
  @override
  String get name => 'revertMessage'; // if you don't override it will be the name of class: 'RevertMessageAction' 

  @override
  void call(CommitFn commit, Map<String, dynamic> state, [dynamic params]) async {
    final reversedMessage = state['message'].toString().split('').reversed.join('');

    commit('/changeMessage', reversedMessage);
  }
}

```

{% hint style="info" %}
The actions can be async and also return any value that you need
{% endhint %}

## Registering the action the store

```dart
class MyStore extends Store {
  MyStore() : super(
    Module(
      state: {
        'message': 'An message',
      },
      mutations: [
        UpdateMessageMutation(),
      ],
      actions: [
        RevertMessageAction(),
      ],
    ),
  );
}
```

## Dispatching the action

```dart
store.dispatch('/revertMessage');
```

