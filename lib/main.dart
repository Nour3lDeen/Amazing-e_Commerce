import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:flutter/material.dart';

import 'my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedHelper.init();
  runApp(
    /*EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translation',
        fallbackLocale: const Locale('en'),*/
    const MyApp(),
  );
}




