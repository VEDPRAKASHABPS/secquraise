import 'dart:async';
import 'package:secquraise/colors.dart';
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
  bool connectivityStatus = true;
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
        connectivityStatus = result.toString() as bool;
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Capture"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.black, // Default text color
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'SECQUR',
                      style: TextStyle(
                          color:titleColor

   )), // Color for the non-colored part
                  TextSpan(
                      text: 'AI',
                      style: TextStyle(color: aitext)), // Color for 'PA'
                  TextSpan(
                      text: 'SE',
                      style: TextStyle(
                          color:textColor)), // Color for the non-colored part
                ],
              ),
            ),
            // const Text(
            //   'SECQURAISE',
            //   style: TextStyle(color:titleColor,
            //     fontSize: 40,
            //     fontWeight: FontWeight.w600,

            //   ),

            // ),
            const SizedBox(height: 10),
            Text(
              " $timestamp",
              style: const TextStyle(
                color: textColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: size.height / 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Left Boxes
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor, // You can set the border color
                          width: 2.0, // You can set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // You can round the corners
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Capture Count",

                          style: TextStyle(
                              color: textColor,
                              fontSize: 18), // Adjust the font size
                        ),
                      ),
                    ),

                    Container(
                      width: 150, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor, // You can set the border color
                          width: 2.0, // You can set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // You can round the corners
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Frequency (min)",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 18), // Adjust the font size
                        ),
                      ),
                    ),

                    Container(
                      width: 150, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor, // You can set the border color
                          width: 2.0, // You can set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // You can round the corners
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Connectivity",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 18), // Adjust the font size
                        ),
                      ),
                    ),

                    Container(
                      width: 150, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor, // You can set the border color
                          width: 2.0, // You can set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // You can round the corners
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Battery Charging",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 18), // Adjust the font size
                        ),
                      ),
                    ),

                    Container(
                      width: 140, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor, // You can set the border color
                          width: 2.0, // You can set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // You can round the corners
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Battery Charge",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 18), // Adjust the font size
                        ),
                      ),
                    ),

                    Container(
                      width: 150, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor, // You can set the border color
                          width: 2.0, // You can set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // You can round the corners
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Location",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 18), // Adjust the font size
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
                      width: 100, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor, // You can set the border color
                          width: 2.0, // You can set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // You can round the corners
                      ),
                      child: Center(
                        child: Text(
                          " $captureCount",
                          style: const TextStyle(
                              color: dataread,
                              fontSize: 18), // Adjust the font size
                        ),
                      ),
                    ),

                    Container(
                      width: 100, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor, // You can set the border color
                          width: 2.0, // You can set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // You can round the corners
                      ),
                      child: Center(
                        child: Text(
                          " $frequency",
                          style: const TextStyle(
                              color: dataread,
                              fontSize: 18), // Adjust the font size
                        ),
                      ),
                    ),

                    Container(
                      width: 100, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor, // You can set the border color
                          width: 2.0, // You can set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // You can round the corners
                      ),
                      child: Center(
                        child: Text(
                          " ${connectivityStatus ? "ON" : "OFF"} ",
                          style: const TextStyle(
                              color: dataread,
                              fontSize: 18), // Adjust the font size
                        ),
                      ),
                    ),

                    Container(
                      width: 100, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor, // You can set the border color
                          width: 2.0, // You can set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // You can round the corners
                      ),
                      child: Center(
                        child: Text(
                          " ${isCharging ? "ON" : "OFF"}",
                          style: const TextStyle(
                              color: dataread,
                              fontSize: 18), // Adjust the font size
                        ),
                      ),
                    ),

                    Container(
                      width: 100, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor, // You can set the border color
                          width: 2.0, // You can set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // You can round the corners
                      ),
                      child: Center(
                        child: Text(
                          " $batteryCharge%",
                          style: const TextStyle(
                              color: dataread,
                              fontSize: 18), // Adjust the font size
                        ),
                      ),
                    ),

                    Container(
                      width: 160, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor, // You can set the border color
                          width: 2.0, // You can set the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            10), // You can round the corners
                      ),
                      child: Center(
                        child: Text(
                          " ${currentLocation?.toString()}",
                          style: const TextStyle(
                              color: dataread,
                              fontSize: 15), // Adjust the font size
                        ),
                      ),
                    ),

                    // Add more right boxes as needed
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: size.width * 0.85,
              child: ElevatedButton(
                onPressed: manualDataRefresh,
                child: const Text("Manual Data Refresh"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
