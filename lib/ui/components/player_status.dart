import 'package:flutter/material.dart';

class PlayerStatus extends StatelessWidget {
  final bool? isConfirmed;

  const PlayerStatus({this.isConfirmed, super.key});

  Color getColor() => switch (isConfirmed) {
    true => Colors.teal,
    false => Colors.red,
    null => Colors.grey,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(color: getColor(), shape: BoxShape.circle),
    );
  }
}
