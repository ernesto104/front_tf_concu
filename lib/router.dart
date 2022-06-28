import 'package:flutter/material.dart';
import 'package:tf_concurrencia/pages/edit.dart';
import 'package:tf_concurrencia/pages/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'home':
      return MaterialPageRoute(builder: (context) => Home());

    case '/editar':
      return MaterialPageRoute(builder: (context) => Edit());
    default:
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ));
  }
}
