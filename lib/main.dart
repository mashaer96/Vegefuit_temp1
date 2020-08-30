import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vegefruit/screens/admin_tabs_screen.dart';

import './screens/cart_screen.dart';
import './screens/edit_products_screen.dart';
import './screens/add_product.screen.dart';
//import './screens/products_overview_screen.dart';
import './screens/select_products_screen.dart';
import './screens/login_screen.dart';
import './screens/product_details_screen.dart';
import 'screens/user_tabs_screen.dart';
import './localization/demo_localization.dart';
// import './routes/custom_route.dart';
// import './routes/route_names.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Tajawal',
        primarySwatch: Colors.lightGreen,
        canvasColor: Color.fromRGBO(255, 245, 229, 1),
      ),
      locale: _locale,
      supportedLocales: [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        DemoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      // onGenerateRoute: CustomRoute.allRoutes,
      //initialRoute: homeRoute,
      //home: TabsScreen(),
      home: LoginScreen(),
      routes: {
        '/adminTabsScreen': (ctx) => AdminTabsScreen(),
        '/productDetails': (ctx) => ProductDetailsScreen(),
        '/tabScreen': (ctx) => TabsScreen(),
        '/cartScreen': (ctx) => CartScreen(),
        '/selectProductsScreen': (ctx) => SelectProductsScreen(),
        '/editProductsScreen': (ctx) => EditProductsScreen(),
        '/addProductScreen': (ctx) => AddProductScreen(),
      },
    );
  }
}
