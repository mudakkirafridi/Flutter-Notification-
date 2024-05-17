import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notification/services/notification_services.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  NotificationServices services = NotificationServices();

  @override
  void initState() {
    services.requestPermission();
    services.firebaseInit(context);
    services.getToken().then((value){
      debugPrint(value);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(onPressed: (){
              services.getToken().then((value)async{
                var data = {
                  'to': value.toString(),
                  'priority': 'high',
"notification" :{
  'title': 'mudakir afridi',
  'body': 'this is a simple notification'
},
'data':{
'type': 'chat',
'id': '12345'
}
                };
await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),body:  jsonEncode(data) ,
headers: {
'Content-Type': 'application/json; charset=UTF-8',
'Authorization': "key=AAAAUHprN2o:APA91bFC-o-VVjcTj4cy7ZLx3iXd0jvg9QB7m1qpHxIc13h9GmfdSw5fkPmo-DErKDddmSh7aMokOGiNJrdQ061cVhWKQ-JaXOkl7yhb0_5Aahboc5AfDAl_7vu7tMvZp9vaVj7Wf4Zx"
}      
);
              });
            }, child: const Text('Show')),
          )
        ],
      ),
    );
  }
}