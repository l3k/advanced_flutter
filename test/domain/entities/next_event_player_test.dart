import 'package:flutter_test/flutter_test.dart';

class NextEventPlayer {
  final String id;
  final String name;
  late final String initials;
  final String? photo;
  final String? position;
  final bool isComfirmed;
  final DateTime? confirmationDate;

  NextEventPlayer({
    required this.id,
    required this.name,
    required this.isComfirmed,
    this.photo,
    this.position,
    this.confirmationDate,
  }) {
    initials = _getInitials();
  }

  String _getInitials() {
    final names = name.split(' ');
    final firstChar = names.first[0];
    final lastChar = names.last[0];
    return '$firstChar$lastChar'.toUpperCase();
  }
}

void main() {
  String initialsOf(String name) =>
      NextEventPlayer(id: '', name: name, isComfirmed: true).initials;
  test('should return the first letter of the first and last name', () {
    expect(initialsOf('John Doe'), 'JD');

    expect(initialsOf('Jane Smith'), 'JS');

    expect(initialsOf('Jack Daniels Jr'), 'JJ');
  });
}
