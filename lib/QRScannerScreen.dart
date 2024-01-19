import 'package:flutter/material.dart';
//qr scanner ui
class QRScannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Attendance Scanner'),
        backgroundColor: Colors.deepPurple, // Change the app bar color
        actions: [
          IconButton(
            icon: Icon(Icons.settings), // Add a settings icon to the app bar
            onPressed: () {
              // Placeholder for settings functionality
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Placeholder for QR scanning logic
            _showScanningResult(context);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple, // Change the button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // Round the button corners
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.qr_code, // Add a QR code icon to the button
                  size: 30.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  'Scan QR Code for Attendance',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
//dialog box popup after scanning
  void _showScanningResult(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Scanning Result'),
          content: Text('Attendance recorded.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}