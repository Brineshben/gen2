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
    _timer =
        Timer.periodic(const Duration(seconds: 5), (_) => fetchAllStatus());
  }

  Future<void> fetchAllStatus() async {
    const baseUrl = "http://192.168.1.32:8000";

    try {
      setState(() => isLoading = true);

      final armResponse = await http.get(Uri.parse("$baseUrl/arm/arm/list/"));
      final jointResponse =
          await http.get(Uri.parse("$baseUrl/arm/joint/list/"));
      final gripperResponse =
          await http.get(Uri.parse("$baseUrl/arm/gripper/list/"));

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

        // 🛠 Force j2 to arm 2 manually
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
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  Widget buildSide(String armNumber) {
    final arm = armData[armNumber];
    final joints = jointDataByArm[armNumber] ?? [];
    final gripper = gripperData[armNumber];

    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(8),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Arm Section
              Text("Arm $armNumber",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              if (arm != null) ...[
                Text("Ctrl Mode: ${arm["ctrl_mode"]}"),
                Text("Status: ${arm["arm_status"]}"),
                Text("Teach Mode: ${arm["teach_mode"]}"),
                Text("Motion: ${arm["motion_status"]}"),
                Text("Trajectory: ${arm["trajectory_num"]}"),
              ] else
                const Text("No arm data"),
              const Divider(),

              // Joint Section
              const Text("Joints",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              joints.isEmpty
                  ? const Text("No joints found")
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: joints.map((joint) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Joint: ${joint["joint_number"]}"),
                              Text("Comms: ${joint["comms"]}"),
                              Text("Motor: ${joint["motor"]}"),
                              Text("Limit: ${joint["limit"]}"),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
              const Divider(),

              // Gripper Section
              const Text("Gripper",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              if (gripper != null) ...[
                Text("Voltage Low: ${gripper["voltage_too_low"]}"),
                Text("Overheating: ${gripper["motor_overheating"]}"),
                Text("Overcurrent: ${gripper["driver_overcurrent"]}"),
                Text("Driver Status: ${gripper["driver_enable_status"]}"),
                Text("Sensor: ${gripper["sensor_status"]}"),
              ] else
                const Text("No gripper data"),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Robot Full Status',
            style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
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
                      buildSide("1"), // Left column
                      buildSide("2"), // Right column
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
