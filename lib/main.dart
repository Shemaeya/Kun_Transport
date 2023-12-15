import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kun_transport/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:kun_transport/screens/welcom_view.dart';
import 'package:kun_transport/service/notification_services.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Future<void> _firebaseMessagingBackgroundHandler(message) async {
  await Firebase.initializeApp();
}

var initializationSettingsAndroid =
    const AndroidInitializationSettings('app_icon');

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languageCode = sp.getString('language_code') ?? '';
  NotificationService().initNotification();
  NotifyHelper().initializeNotification();

  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  // final String locale;
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint("onMessage:");
        log("onMessage: $message");
        final snackBar =
            SnackBar(content: Text(message.notification?.title ?? ""));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => LanguageChangeController()),
    //   ],
    //   child: Consumer<LanguageChangeController>(
    //       builder: (context, provider, child) {
    //     if (locale.isEmpty) {
    //       provider.changeLanguage(const Locale('en'));
    //     }

    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        breakpoints: const [
          ResponsiveBreakpoint.resize(240, name: MOBILE),
          ResponsiveBreakpoint.autoScale(650, name: TABLET),
          ResponsiveBreakpoint.autoScale(900, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ResponsiveBreakpoint.resize(2468, name: '4K'),
        ],
      ),
      title: 'Kun Transport',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // locale: locale == ''
      //     ? const Locale('en')
      //     : provider.appLocale == null
      //         ? const Locale('en')
      //         : provider.appLocale,
      // localizationsDelegates: const [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en'),
      //   Locale('fr'),
      // ],
      home: const SplashScreen(),
    );
    //   }),
    // );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSplashScreen(
        backgroundColor: const Color(0xFF232441),
        splash: Lottie.asset('assets/images/car.json'),
        splashIconSize: 400,
        duration: 2000,
        // backgroundColor: Colors.grey
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        nextScreen: const WelcomView(),
      ),
    );
  }
}
