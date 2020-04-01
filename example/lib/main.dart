import 'package:flutter/material.dart';
import 'package:vuex4flutter/vuex4flutter.dart';

import 'store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Vuex4FlutterProvider(
      store: MyStore(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: Content(),
        floatingActionButton: Fab(),
      ),
    );
  }
}

class Content extends StatelessWidget {
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

class Fab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: fetchItems,
    );
  }

  Future<void> fetchItems() {
    final store = Vuex4FlutterProvider.store;
    return store.dispatch('/cart/FetchCartItemsAction');
  }
}

