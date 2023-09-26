import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:secquraise/imo.dart';

void main() {
  runApp(const MyApp());
}


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
       theme: ThemeData(
        scaffoldBackgroundColor:Color(0xFF010005), // Set background color to black
        // primaryColor: Colors.white, // Set text color to white
      ),
    );
  }
}




// Push data to Firebase
void pushDataToFirebase() {
  // ignore: deprecated_member_use
  final databaseReference = FirebaseDatabase.instance.reference();
  databaseReference.child("data").push().set({
    "timestamp": timestamp,
    "captureCount": captureCount,
    "frequency": frequency,
    "connectivityStatus": connectivityStatus,
    "isCharging": isCharging,
    "batteryCharge": batteryCharge,
    "location": currentLocation,
  });
}

mixin connectivityStatus {
}

mixin frequency {
}

mixin currentLocation {
}

mixin batteryCharge {
}

mixin isCharging {
}

mixin captureCount {
}

mixin timestamp {
}