import 'package:flutter/material.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  final defaultAppbar = AppBar(
    title: const Text('Watch'),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search),
      ),
      const SizedBox(width: 10),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watch'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        color: const Color.fromRGBO(246, 246, 250, 1),
        child: const Center(
          child: Text('watch screen'),
        ),
      ),
    );
  }
}
