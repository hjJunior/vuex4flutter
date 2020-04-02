# Step 2: Using the connector

```dart
class YourContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Vuex4FlutterConnector(
      builder: (context, store) {
        final isEmpty = store.getter('/cart/isEmpty');
        final isFetching = store.getter('/cart/isFetching');

        return Center(
          child: isFetching
            ? CircularProgressIndicator()
            : Text('The cart is empty: $isEmpty'),
        );
      }
    );
  }
}
```



