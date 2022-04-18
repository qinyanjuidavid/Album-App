import 'package:crudapp/controllers/album_providers.dart';
import 'package:crudapp/services/api_services.dart';
import 'package:crudapp/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AlbumProvider>(
          create: (context) => AlbumProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomeScreen(),
      ),
    );
  }
}
