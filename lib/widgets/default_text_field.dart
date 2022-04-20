import 'package:flutter/material.dart';

class DefaultTextFiel extends StatelessWidget {
  const DefaultTextFiel({
    Key? key,
    required this.controller,
    required this.lable,
    this.enabled = true,
  }) : super(key: key);

  final TextEditingController controller;
  final String lable;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(lable),
      ),
    );
  }
}
