import 'package:flutter/material.dart';

import 'vuex4flutter.dart';

typedef ConnectorBuilder = Widget Function(BuildContext context, Store store);

class Vuex4FlutterConnector extends StatelessWidget {
  final ConnectorBuilder builder;

  Vuex4FlutterConnector({this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Vuex4FlutterProvider.store.state,
      builder: (context, _) => builder(context, Vuex4FlutterProvider.store),
    );
  }
}
