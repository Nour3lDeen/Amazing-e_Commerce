import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
 // await Firebase.initializeApp();
  await SharedHelper.init();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('ar'), Locale('en')],
    path: 'assets/translation',
    fallbackLocale: const Locale('ar'),
    startLocale: const Locale('ar'),
    child: const MyApp(),
  ));

}
