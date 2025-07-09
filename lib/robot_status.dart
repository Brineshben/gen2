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
    // const baseUrl = "http://192.168.11.202:7500";
    const  baseUrl = "http://192.168.1.80:7500";

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
      // print("Error: $e");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("No Response From Api")),
      // );
    }
  }

  Widget buildSide(String armNumber) {
    final arm = armData[armNumber];
    final joints = jointDataByArm[armNumber] ?? [];
    final gripper = gripperData[armNumber];

    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(8),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Arm Section
              Text("ARM $armNumber",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
              const SizedBox(height: 6),
              if (arm != null) ...[
                Text("Ctrl Mode: ${arm["ctrl_mode"]}",   style: const TextStyle(color: Colors.white)),
                Text("Status: ${arm["arm_status"]}", style: const TextStyle(color: Colors.white)),
                Text("Teach Mode: ${arm["teach_mode"]}", style: const TextStyle(color: Colors.white)),
                Text("Motion: ${arm["motion_status"]}", style: const TextStyle(color: Colors.white)),
                Text("Trajectory: ${arm["trajectory_num"]}", style: const TextStyle(color: Colors.white)),
              ] else
                const Text("No arm data", style: const TextStyle(color: Colors.white)),
              const Divider(),
              // Gripper Section
              const Text("GRIPPER",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20)),
              if (gripper != null) ...[
                Text("Voltage Low: ${gripper["voltage_too_low"]}", style: const TextStyle(color: Colors.white)),
                Text("Overheating: ${gripper["motor_overheating"]}", style: const TextStyle(color: Colors.white)),
                Text("Overcurrent: ${gripper["driver_overcurrent"]}", style: const TextStyle(color: Colors.white)),
                Text("Driver Error Status: ${gripper["driver_error_status"]}", style: const TextStyle(color: Colors.white)),
                Text("Homing Status: ${gripper["homing_status"]}", style: const TextStyle(color: Colors.white)),
                Text("Driver Status: ${gripper["driver_enable_status"]}", style: const TextStyle(color: Colors.white)),
                Text("Sensor: ${gripper["sensor_status"]}", style: const TextStyle(color: Colors.white)),
              ] else
                const Text("No gripper data", style: const TextStyle(color: Colors.white)),
              const Divider(),
              // Joint Section
              const Text("JOINTS",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20)),
              joints.isEmpty
                  ? const Text("No joints found", style: TextStyle(color: Colors.white))
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: joints.map<Widget>((joint) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Joint: ${joint["joint_number"]}", style: const TextStyle(color: Colors.white)),
                        Text("Comms: ${joint["comms"]}", style: const TextStyle(color: Colors.white)),
                        Text("Motor: ${joint["motor"]}", style: const TextStyle(color: Colors.white)),
                        Text("Limit: ${joint["limit"]}", style: const TextStyle(color: Colors.white)),
                        const Divider(color: Colors.grey),
                      ],
                    ),
                  );
                }).toList(),
              ),


            ],
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
        title: const Text('Robot Full Status',
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
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
