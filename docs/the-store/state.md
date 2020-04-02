# State

The state of your application is stored in a dynamic Map

## Defining the state object

The state object is just a dynamic Map, that **shouldn't** be modified directly, which will hold the state of whatever you need on your application.

It's important to be a `Map<String, dynamic>` to allow you to register whatever kind of state

```dart
  final Map<String, dynamic> state = {
    'message': 'A message',
  };
```

## Registering the state on Store

To start a store, create a class which extends from `Store` and on the call of the constructor, pass your **rootModule**

```dart
class MyStore extends Store {
  MyStore() : super(
    Module(
      state: {
        'message': 'A message',
      }
    ),
  );
}

```

{% hint style="info" %}
It's good to know the API of a `Module`, you can check on the [pub documentation](https://pub.dev/documentation/vuex4flutter/latest/types_module/Module-class.html), or on the **Modules** section 
{% endhint %}

