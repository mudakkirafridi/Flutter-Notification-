import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification/firebase_options.dart';
import 'package:notification/view/home.dart';




void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);
  runApp(const MyApp());
}




@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  debugPrint(message.notification!.title);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyWidget(),
    );
  }
}
