import 'package:flutter/material.dart';
import 'package:flutter_provider_of_app/Common/theme.dart';
import 'package:flutter_provider_of_app/Models/cart.dart';
import 'package:flutter_provider_of_app/Models/catalog.dart';
import 'package:flutter_provider_of_app/Screens/cart.dart';
import 'package:flutter_provider_of_app/Screens/catalog.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      // In this sample app, CatalogModel never changes, so a simple Provider
      // is sufficient.
      Provider(create: (context) => CatalogModel()),
      // CartModel is implemented as a ChangeNotifier, which calls for the use
      // of ChangeNotifierProvider. Moreover, CartModel depends
      // on CatalogModel, so a ProxyProvider is needed.
      ChangeNotifierProxyProvider<CatalogModel, CartModel>(
        create: (context) => CartModel(),
        update: (context, catalog, cart) {
          cart.catalog = catalog;
          return cart;
        },
      ),
    ],child: MaterialApp(
      title: 'Provider Demo',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => MyCatalog(),
        '/cart': (context) => MyCart(),
      },
    ),);
  }
}
