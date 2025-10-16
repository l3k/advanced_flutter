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
    return '${names[0][0]}${names[1][0]}';
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
  });
}
