import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_management_app/add_transaction/screen_add_transaction.dart';
import 'package:personal_management_app/db/category/transaction/transaction_model.dart';
import 'package:personal_management_app/screens/home/screen_home.dart';
import 'package:personal_management_app/screens/models/Category/category_model.dart';

Future<void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  
  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter());
  }

   if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ScreenHome(),
      routes: {
        ScreenAddTransaction.routName:(ctx)=>const ScreenAddTransaction(),
      },
    );
  }


}
