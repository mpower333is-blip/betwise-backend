import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget{
const ProfileScreen({super.key});

@override
Widget build(BuildContext context){
return Scaffold(
appBar:
AppBar(
title:
Text('Profile'),
),
body: ListView(
children:[
ListTile(
title:
Text(
'Upgrade To Premium'
),
),
ListTile(
title:
Text(
'PayFast Subscription'
),
),
ListTile(
title:
Text(
'Responsible Gambling'
),
),
],
),
);
}
}