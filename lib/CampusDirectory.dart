import 'package:flutter/material.dart';
//dummy listing
class CampusDirectory {
  Map<String, String> contacts = {
    'En Amsyar': '011-333 4444',
    'En Adib': '011-222 2222',
    'En Ronald': '013-5454-8888',
  };

  void addContact(String name, String phoneNumber) {
    contacts[name] = phoneNumber;
  }
}
