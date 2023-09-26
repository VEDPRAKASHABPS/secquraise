import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:connectivity/connectivity.dart';
import 'package:battery/battery.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Location location = Location();
  final Connectivity _connectivity = Connectivity();
  final Battery _battery = Battery();

  String timestamp = "";
  int captureCount = 0;
  int frequency = 15; // Default frequency in minutes
  String connectivityStatus = "Unknown";
  bool isCharging = false;
  int batteryCharge = 0;
  Map<String, double>? currentLocation;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Initialize the location, connectivity, and battery listeners
  void initPlatformState() async {
    location.onLocationChanged.listen((locationData) {
      setState(() {
        currentLocation = {
          "latitude": locationData.latitude!,
          "longitude": locationData.longitude!,
        };
      });
    });

    _connectivity.onConnectivityChanged.listen((result) {
      setState(() {
        connectivityStatus = result.toString();
      });
    });

    _battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        isCharging = state == BatteryState.charging;
      });
    });

    _battery.batteryLevel.then((value) {
      setState(() {
        batteryCharge = value;
      });
    });

    // You can use a timer to refresh data based on the specified frequency
    // This timer should be cancelled when the app is killed
    const oneMinute = Duration(minutes: 1);
    Timer.periodic(oneMinute, (Timer timer) {
      setState(() {
        timestamp = DateTime.now().toString();
        captureCount++;
      });
    });
  }

  // Function to manually refresh data
  void manualDataRefresh() {
    setState(() {
      timestamp = DateTime.now().toString();
      captureCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Capture"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Left Boxes
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 200, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // You can set the border color
                    width: 2.0, // You can set the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // You can round the corners
                ),
                child: Center(
                  child: Text(
                    "Capture Count: $captureCount",
                    style: const TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
              ),

              Container(
                width: 200, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // You can set the border color
                    width: 2.0, // You can set the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // You can round the corners
                ),
                child: Center(
                  child: Text(
                    "Frequency (min): $frequency",
                    style: TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
              ),

              Container(
                width: 200, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // You can set the border color
                    width: 2.0, // You can set the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // You can round the corners
                ),
                child: Center(
                  child: Text(
                    "Connectivity: $connectivityStatus",
                    style:
                        const TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
              ),

              Container(
                width: 200, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // You can set the border color
                    width: 2.0, // You can set the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // You can round the corners
                ),
                child: Center(
                  child: Text(
                    "Battery Charging: $isCharging",
                    style:
                        const TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
              ),

              Container(
                width: 200, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // You can set the border color
                    width: 2.0, // You can set the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // You can round the corners
                ),
                child: Center(
                  child: Text(
                    "Battery Charge: $batteryCharge%",
                    style:
                        const TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
              ),

              Container(
                width: 200, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // You can set the border color
                    width: 2.0, // You can set the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // You can round the corners
                ),
                child: Center(
                  child: Text(
                    "Location: ${currentLocation?.toString()}",
                    style:
                        const TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
              ),

              // Add more left boxes as needed
            ],
          ),
          // Right Boxes
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 200, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // You can set the border color
                    width: 2.0, // You can set the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // You can round the corners
                ),
                child: Center(
                  child: Text(
                    "Capture Count: $captureCount",
                    style: const TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
              ),

              Container(
                width: 200, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // You can set the border color
                    width: 2.0, // You can set the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // You can round the corners
                ),
                child: Center(
                  child: Text(
                    "Frequency (min): $frequency",
                    style: TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
              ),

              Container(
                width: 200, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // You can set the border color
                    width: 2.0, // You can set the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // You can round the corners
                ),
                child: Center(
                  child: Text(
                    "Connectivity: $connectivityStatus",
                    style:
                        const TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
              ),

              Container(
                width: 200, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // You can set the border color
                    width: 2.0, // You can set the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // You can round the corners
                ),
                child: Center(
                  child: Text(
                    "Battery Charging: $isCharging",
                    style:
                        const TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
              ),

              Container(
                width: 200, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // You can set the border color
                    width: 2.0, // You can set the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // You can round the corners
                ),
                child: Center(
                  child: Text(
                    "Battery Charge: $batteryCharge%",
                    style:
                        const TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
              ),

              Container(
                width: 50, // Adjust the width as needed
                height: 30, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // You can set the border color
                    width: 2.0, // You can set the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // You can round the corners
                ),
                child: Center(
                  child: Text(
                    "Location: ${currentLocation?.toString()}",
                    style:
                        const TextStyle(fontSize: 18), // Adjust the font size
                  ),
                ),
              ),

              // Add more right boxes as needed
            ],
          ),
        ],
      ),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[

      //       Container(
      //         width: 200, // Adjust the width as needed
      //         height: 50, // Adjust the height as needed
      //         decoration: BoxDecoration(
      //           border: Border.all(
      //             color: Colors.blue, // You can set the border color
      //             width: 2.0, // You can set the border width
      //           ),
      //           borderRadius:
      //               BorderRadius.circular(10), // You can round the corners
      //         ),
      //         child: Center(
      //           child: Text(
      //             "Capture Count: $captureCount",
      //             style: const TextStyle(fontSize: 18), // Adjust the font size
      //           ),
      //         ),
      //       ),

      //       Container(
      //         width: 200, // Adjust the width as needed
      //         height: 50, // Adjust the height as needed
      //         decoration: BoxDecoration(
      //           border: Border.all(
      //             color: Colors.blue, // You can set the border color
      //             width: 2.0, // You can set the border width
      //           ),
      //           borderRadius:
      //               BorderRadius.circular(10), // You can round the corners
      //         ),
      //         child: Center(
      //           child: Text(
      //             "Frequency (min): $frequency",
      //             style: const TextStyle(fontSize: 18), // Adjust the font size
      //           ),
      //         ),
      //       ),

      //       Container(
      //         width: 200, // Adjust the width as needed
      //         height: 50, // Adjust the height as needed
      //         decoration: BoxDecoration(
      //           border: Border.all(
      //             color: Colors.blue, // You can set the border color
      //             width: 2.0, // You can set the border width
      //           ),
      //           borderRadius:
      //               BorderRadius.circular(10), // You can round the corners
      //         ),
      //         child: Center(
      //           child: Text(
      //             "Connectivity: $connectivityStatus",
      //             style: const TextStyle(fontSize: 18), // Adjust the font size
      //           ),
      //         ),
      //       ),

      //       Container(
      //         width: 200, // Adjust the width as needed
      //         height: 50, // Adjust the height as needed
      //         decoration: BoxDecoration(
      //           border: Border.all(
      //             color: Colors.blue, // You can set the border color
      //             width: 2.0, // You can set the border width
      //           ),
      //           borderRadius:
      //               BorderRadius.circular(10), // You can round the corners
      //         ),
      //         child: Center(
      //           child: Text(
      //             "Battery Charging: $isCharging",
      //             style: const TextStyle(fontSize: 18), // Adjust the font size
      //           ),
      //         ),
      //       ),

      //       Container(
      //         width: 200, // Adjust the width as needed
      //         height: 50, // Adjust the height as needed
      //         decoration: BoxDecoration(
      //           border: Border.all(
      //             color: Colors.blue, // You can set the border color
      //             width: 2.0, // You can set the border width
      //           ),
      //           borderRadius:
      //               BorderRadius.circular(10), // You can round the corners
      //         ),
      //         child: Center(
      //           child: Text(
      //             "Battery Charge: $batteryCharge%",
      //             style: const TextStyle(fontSize: 18), // Adjust the font size
      //           ),
      //         ),
      //       ),

      //       Container(
      //         width: 200, // Adjust the width as needed
      //         height: 50, // Adjust the height as needed
      //         decoration: BoxDecoration(
      //           border: Border.all(
      //             color: Colors.blue, // You can set the border color
      //             width: 2.0, // You can set the border width
      //           ),
      //           borderRadius:
      //               BorderRadius.circular(10), // You can round the corners
      //         ),
      //         child: Center(
      //           child: Text(
      //             "Location: ${currentLocation?.toString()}",
      //             style: const TextStyle(fontSize: 18), // Adjust the font size
      //           ),
      //         ),
      //       ),

      //       // Text("Timestamp: $timestamp"),
      //       // Text("Capture Count: $captureCount"),
      //       // Text("Frequency (min): $frequency"),
      //       // Text("Connectivity: $connectivityStatus"),
      //       // Text("Battery Charging: $isCharging"),
      //       // Text("Battery Charge: $batteryCharge%"),
      //       // Text("Location: ${currentLocation?.toString()}"),
      //       ElevatedButton(
      //         onPressed: manualDataRefresh,
      //         child: const Text("Manual Data Refresh"),
      //       ),
      //     ],

      //   ),

      // ),
    );
  }
}
