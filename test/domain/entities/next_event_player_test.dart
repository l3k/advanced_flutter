import 'package:flutter_test/flutter_test.dart';

class NextEventPlayer {
  final String id;
  final String name;
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
  });

  String getInitials() {
    final names = name.split(' ');
    final firstChar = names.first[0];
    final lastChar = names.last[0];
    return '$firstChar$lastChar'.toUpperCase();
  }
}

void main() {
  NextEventPlayer makeSut(String name) =>
      NextEventPlayer(id: '', name: name, isComfirmed: true);
  test('should return the first letter of the first and last name', () {
    expect(makeSut('John Doe').getInitials(), 'JD');

    expect(makeSut('Jane Smith').getInitials(), 'JS');

    expect(makeSut('Jack Daniels Jr').getInitials(), 'JJ');
  });
}
