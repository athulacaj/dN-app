import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'commonProviders.dart';
import 'homeScreen/homescreen.dart';
import 'provider.dart';
import 'screens/splashscreen.dart';
import 'searchProvider.dart';
import 'screens/MyOrders/MyOrders.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlareCache.doesPrune = false;
  Provider.debugCheckInvalidValueType = null;
  preCache().then((_) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => IsInList()),
      ChangeNotifierProvider(create: (context) => SearchProvider()),
      ChangeNotifierProvider(create: (context) => CommonProvider()),
    ], child: MyApp()));
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.purple.shade600,
      statusBarIconBrightness: Brightness.light,
    ));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreenWindow.id,
      navigatorKey: navigatorKey,
      title: 'Daily Needs',
      theme: ThemeData(
        primarySwatch: Colors.purple,
//          textTheme: GoogleFonts.gayathriTextTheme(
//            Theme.of(context).textTheme,
//          ),
      ),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SplashScreenWindow.id: (context) => SplashScreenWindow(),
        MyOrders.id: (context) => MyOrders(),
      },
    );
  }
}

Future<void> preCache() async {
  await cachedActor(
    AssetFlare(bundle: rootBundle, name: 'assets/flare/success.flr'),
  );
}
