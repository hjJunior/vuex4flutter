# Step 1: Registering the provider

{% code title="main.dart" %}
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Vuex4FlutterProvider(
      store: MyStore(),
      child: MaterialApp(
        home: Home(),
      );
    );
  }
}
```
{% endcode %}



