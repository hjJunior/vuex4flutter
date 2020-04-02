# Mutations

## Defining the mutation

```dart
class UpdateMessageMutation extends Mutation {
  @override
  String get name => 'changeMessage'; // if you don't override it will be the name of class: 'UpdateMessageMutation' 
  
  @override
  void call(Map<String, dynamic> state, payload) {
    state['message'] = payload;
  }
}
```

{% hint style="warning" %}
All mutations should be sync, if do you need to perform async operations you must use an action
{% endhint %}

## Registering the mutation on Store

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
    ),
  );
}
```

## Commiting an change

```dart
store.commit('/changeMessage', 'New message');
```

