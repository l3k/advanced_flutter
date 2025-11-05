import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

class PlayerPosition extends StatelessWidget {
  final String? position;

  const PlayerPosition({this.position, super.key});

  String buildPositionLabel() => switch (position) {
    'goalkeeper' => 'Goleiro',
    'defender' => 'Zagueiro',
    'midfielder' => 'Meio-campista',
    'forward' => 'Atacante',
    _ => 'Gandula',
  };

  @override
  Widget build(BuildContext context) {
    return Text(
      buildPositionLabel(),
      style: context.textStyles.labelMedium.apply(
        color: context.colors.scheme.primary.withValues(alpha: 0.7),
      ),
    );
  }
}
