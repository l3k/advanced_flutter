import 'package:flutter_test/flutter_test.dart';

class NextEventPlayerTest {
  final String id;
  final String name;
  final String? photo;
  final String? position;
  final bool isComfirmed;
  final DateTime? confirmationDate;

  NextEventPlayerTest({
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
  test('should return the first letter of the first and last name', () {
    final player = NextEventPlayerTest(
      id: '',
      name: 'John Doe',
      isComfirmed: true,
    );
    expect(player.getInitials(), 'JD');

    final player2 = NextEventPlayerTest(
      id: '',
      name: 'Jane Smith',
      isComfirmed: true,
    );

    expect(player2.getInitials(), 'JS');

    final player3 = NextEventPlayerTest(
      id: '',
      name: 'Jack Daniels Jr',
      isComfirmed: true,
    );

    expect(player3.getInitials(), 'JJ');
  });
}
