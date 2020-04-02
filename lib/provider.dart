import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vuex4flutter/store.dart';

class Vuex4FlutterProvider extends InheritedWidget {
  final Widget child;
  final _getIt = GetIt.instance;

  Vuex4FlutterProvider({
    @required Store store,
    @required this.child,
  }) : super(child: child) {
    if (!_getIt.isRegistered<Store>())
      _getIt.registerSingleton<Store>(store);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Store get store => GetIt.instance.get<Store>();
}
