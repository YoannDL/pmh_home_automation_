import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthomeui/util/smart_device_box.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // padding constants
  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  // list of smart devices
  List mySmartDevices = [
    // [ smartDeviceName, iconPath , powerStatus ]
    ["Smart Light", "lib/icons/light-bulb.png", true],
    ["Smart AC", "lib/icons/air-conditioner.png", false],
    ["Smart TV", "lib/icons/smart-tv.png", false],
    ["Smart Fan", "lib/icons/fan.png", false],
  ];

  // power button switched
  void powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[300],
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // app bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // menu icon
                Image.asset(
                  'lib/icons/menu.png',
                  height: 45,
                  color: Colors.grey[800],
                ),

                // account icon
                Icon(
                  Icons.person,
                  size: 45,
                  color: Colors.grey[800],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // welcome home
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Home,",
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                ),
                Text(
                  'Yoann',
                  style: GoogleFonts.bebasNeue(fontSize: 72),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Divider(
              thickness: 1,
              color: Color.fromARGB(255, 204, 204, 204),
            ),
          ),

          const SizedBox(height: 25),

          // smart devices grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              "Smart Devices",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.grey.shade800,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // grid
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildSmartDeviceBox(0),
                      ),
                      Expanded(
                        child: _buildSmartDeviceBox(1),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildSmartDeviceBox(2),
                      ),
                      Expanded(
                        child: _buildSmartDeviceBox(3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildSmartDeviceBox(int index) {
  return InkWell(
    onTap: () {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LightingPage()),
        );
      }
    },
    child: SmartDeviceBox(
      smartDeviceName: mySmartDevices[index][0],
      iconPath: mySmartDevices[index][1],
      powerOn: mySmartDevices[index][2],
      onChanged: (value) => powerSwitchChanged(value, index),
    ),
  );
}


  
}
//page for the 4 lights
class LightingPage extends StatefulWidget {
  @override
  _LightingPageState createState() => _LightingPageState();
}

class _LightingPageState extends State<LightingPage> {
  List<bool> lightStates = [false, false, false, false];

  void toggleLight(int index) {
    setState(() {
      lightStates[index] = !lightStates[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lighting Page'),
      ),
      body: GridView.builder(
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.3,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => toggleLight(index),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      'lib/icons/light-bulb.png',
                      color: lightStates[index] ? Colors.yellow : Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Light ${index + 1}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: lightStates[index] ? Colors.yellow : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
