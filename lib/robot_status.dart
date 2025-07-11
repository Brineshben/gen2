import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RobotStatusScreen extends StatefulWidget {
  const RobotStatusScreen({super.key});

  @override
  State<RobotStatusScreen> createState() => _RobotStatusScreenState();
}

class _RobotStatusScreenState extends State<RobotStatusScreen> {
  final StreamController<bool> _dataStreamController = StreamController<bool>();
  bool isLoading = false;
  Timer? _timer;

  Map<String, dynamic> armData = {};
  Map<String, List<dynamic>> jointDataByArm = {};
  Map<String, dynamic> gripperData = {};

  @override
  void initState() {
    super.initState();
    _startAutoRefresh();
    fetchAllStatus();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _dataStreamController.close();
    super.dispose();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => fetchAllStatus());
  }

  Future<void> fetchAllStatus() async {
    const baseUrl = "http://192.168.1.80:7500";

    try {
      setState(() => isLoading = true);

      final armResponse = await http.get(Uri.parse("$baseUrl/arm/arm/list/"));
      final jointResponse = await http.get(Uri.parse("$baseUrl/arm/joint/list/"));
      final gripperResponse = await http.get(Uri.parse("$baseUrl/arm/gripper/list/"));

      if (armResponse.statusCode == 200 &&
          jointResponse.statusCode == 200 &&
          gripperResponse.statusCode == 200) {
        final List armList = jsonDecode(armResponse.body)['data'];
        final List jointList = jsonDecode(jointResponse.body)['data'];
        final List gripperList = jsonDecode(gripperResponse.body)['data'];

        Map<String, dynamic> arms = {};
        Map<String, List<dynamic>> joints = {};
        Map<String, dynamic> grippers = {};

        for (var arm in armList) {
          arms[arm['arm_number']] = arm;
        }

        for (var joint in jointList) {
          String armNum = joint['arm_number'];
          if (joint['joint_number'] == 'j2') {
            armNum = '2'; // override
          }
          joints.putIfAbsent(armNum, () => []).add(joint);
        }

        for (var gripper in gripperList) {
          grippers[gripper['arm_number']] = gripper;
        }

        setState(() {
          armData = arms;
          jointDataByArm = joints;
          gripperData = grippers;
          isLoading = false;
        });

        _dataStreamController.add(true);
      } else {
        throw Exception("Failed to load one or more APIs");
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Widget buildStyledTile(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 15)),
        ],
      ),
    );
  }

  Widget buildSide(String armNumber) {
    final arm = armData[armNumber];
    final joints = jointDataByArm[armNumber] ?? [];
    final gripper = gripperData[armNumber];

    Widget buildStyledTile(String label, String value) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label.toUpperCase(), style: const TextStyle(color: Colors.white70, fontSize: 14,fontWeight: FontWeight.bold)),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 15)),
          ],
        ),
      );
    }

    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ARM $armNumber",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 12),

                if (arm != null) ...[
                  buildStyledTile("Ctrl Mode", "${arm["ctrl_mode"]}"),
                  buildStyledTile("Status", "${arm["arm_status"]}"),
                  buildStyledTile("Teach Mode", "${arm["teach_mode"]}"),
                  buildStyledTile("Motion", "${arm["motion_status"]}"),
                  buildStyledTile("Trajectory", "${arm["trajectory_num"]}"),
                ] else
                  const Text("No arm data", style: TextStyle(color: Colors.white)),

                const SizedBox(height: 20),
                const Text("GRIPPER",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                const SizedBox(height: 10),

                if (gripper != null) ...[
                  buildStyledTile("Voltage Low", "${gripper["voltage_too_low"]}"),
                  buildStyledTile("Overheating", "${gripper["motor_overheating"]}"),
                  buildStyledTile("Overcurrent", "${gripper["driver_overcurrent"]}"),
                  buildStyledTile("Driver Error", "${gripper["driver_error_status"]}"),
                  buildStyledTile("Homing Status", "${gripper["homing_status"]}"),
                  buildStyledTile("Driver Status", "${gripper["driver_enable_status"]}"),
                  buildStyledTile("Sensor", "${gripper["sensor_status"]}"),
                ] else
                  const Text("No gripper data", style: TextStyle(color: Colors.white)),

                const SizedBox(height: 20),
                const Text("JOINTS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                const SizedBox(height: 10),
                joints.isEmpty
                    ? const Text("No joints found", style: TextStyle(color: Colors.white))
                    : Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: joints.map<Widget>((joint) {
                    return Container(
                      width: 160, // Set a fixed width or adjust based on your design
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[700]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Joint: ${joint["joint_number"]}",
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text("Comms: ${joint["comms"]}",
                              style: const TextStyle(color: Colors.white70)),
                          Text("Motor: ${joint["motor"]}",
                              style: const TextStyle(color: Colors.white70)),
                          Text("Limit: ${joint["limit"]}",
                              style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                    );
                  }).toList(),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'ROBOT FULL STATUS',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<bool>(
              stream: _dataStreamController.stream,
              builder: (context, snapshot) {
                if (isLoading && !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSide("1"),
                      buildSide("2"),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
