import 'package:flutter/material.dart';

//declare for listing
class ContactTile extends StatelessWidget {
  final String name;
  final String phoneNumber;


  ContactTile({required this.name, required this.phoneNumber, });
// ui of contact listed after key in
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
          backgroundColor: Colors.purpleAccent,
        ),
        title: Text(name),
        subtitle: Text('Phone: $phoneNumber'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
           
          ],
        ),
      ),
    );
  }
}