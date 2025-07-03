import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gen2/Chat_Page/qalistmodel.dart';
import 'package:gen2/Service/ApiService.dart';

class ChatPage extends StatefulWidget {
  const  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _qaController = TextEditingController();
  final StreamController<QAListModel> _qaStreamController =
  StreamController<QAListModel>.broadcast();
  Timer? pollingTimer;

  bool _lastIsAnswered = true;
  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() async {
    try {
      final data = await ApiServices.getQAList();
      _qaStreamController.add(data);
    } catch (e) {
      _qaStreamController.addError("Error fetching data");
    } finally {
      setState(() {
        _isInitialLoad = false;
      });
      _startPolling();
    }
  }

  void _startPolling() {
    pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        final data = await ApiServices.getQAList();
        _qaStreamController.add(data);
      } catch (e, stackTrace) {
        // Log error (you can use print, debugPrint, or a logger package)
        debugPrint('Polling error: $e');
        // Optionally: print(stackTrace);
      }
    });
  }

  @override
  void dispose() {
    pollingTimer?.cancel();
    _qaStreamController.close();
    _qaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      backgroundColor: Colors.black,
      body: _isInitialLoad
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text("CHAT",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QAListModel>(
              stream: _qaStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                      child: Text('Something went wrong.'));
                }

                final qaList = snapshot.data?.data ?? [];

                if (qaList.isEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() => _lastIsAnswered = true);
                    }
                  });
                  return const Center(child: Text('No questions yet.'));
                }

                final lastItem = qaList.last;

                // ✅ Update input enable/disable status safely
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(
                            () => _lastIsAnswered = lastItem.status == false);
                  }
                });

                return ListView.builder(
                  itemCount: qaList.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final item = qaList[index];
                    final question = item.question ?? '';
                    final answerLines = (item.answer ?? '')
                        .trim()
                        .split('\n')
                        .where((line) => line.trim().isNotEmpty)
                        .toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question bullet
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 25,top: 5),
                              child: Icon(Icons.circle,color: Colors.green,size: 10,),
                              // child: Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: Text(
                                "${question.trim().endsWith('') ? question.trim() : "${question.trim()}?"}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Answer bullets
                        ...answerLines.map((line) => Padding(
                          padding: const EdgeInsets.only(
                              left: 30, bottom: 2),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 25,top: 5),
                                child: Icon(Icons.arrow_forward_ios ,color: Colors.green,size: 10,),
                                // child: Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                              ),
                              SizedBox(width: 5,),
                              Expanded(
                                child: Text(
                                  line.trim(),
                                  style: const TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )),

                        if (index == qaList.length - 1 &&
                            item.status == true)
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Row(
                              children: const [
                                Text(
                                  "🕒 Waiting for Response"
                                      "  ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: TypingDots(),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 16),
                      ],
                    );
                  },
                );
              },
            ),
          ),

          // Redesigned Input Section
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black,
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _qaController,
                      enabled: _lastIsAnswered,
                      decoration: InputDecoration(
                        hintText: _lastIsAnswered
                            ? "Ask your question..."
                            : "Waiting for response...",
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: IconButton(
                      key: ValueKey(_lastIsAnswered),
                      icon: Icon(Icons.send,
                          color: _lastIsAnswered
                              ? Colors.green
                              : Colors.grey),
                      onPressed: _lastIsAnswered
                          ? () async {
                        final question = _qaController.text.trim();
                        if (question.isEmpty) return;

                        await ApiServices.createQA(
                            question: question);
                        _qaController.clear();

                        _loadInitialData(); // Refresh
                      }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
class TypingDots extends StatefulWidget {
  const TypingDots({super.key});

  @override
  State<TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<TypingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dotOne;
  late Animation<double> _dotTwo;
  late Animation<double> _dotThree;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _dotOne = Tween<double>(begin: 0, end: -5).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeInOut)));

    _dotTwo = Tween<double>(begin: 0, end: -5).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeInOut)));

    _dotThree = Tween<double>(begin: 0, end: -5).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.7, curve: Curves.easeInOut)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildDot(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, animation.value),
        child: child,
      ),
      child: Text(
        '•',
        style: TextStyle(fontSize: 24, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildDot(_dotOne),
        buildDot(_dotTwo),
        buildDot(_dotThree),
      ],
    );
  }
}