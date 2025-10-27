import 'package:advanced_flutter/domain/entities/next_event_player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String initialsOf(String name) =>
      NextEventPlayer(id: '', name: name, isConfirmed: true).initials;
  test('should return the first letter of the first and last names', () {
    expect(initialsOf('John Doe'), 'JD');
    expect(initialsOf('Jane Smith'), 'JS');
    expect(initialsOf('Jack Daniels Jr'), 'JJ');
  });

  test('should return the first letters of the first name', () {
    expect(initialsOf('John'), 'JO');
    expect(initialsOf('J'), 'J');
  });

  test('should return "-" when name is empty', () {
    expect(initialsOf(''), '-');
  });

  test('should convert to uppercase', () {
    expect(initialsOf('john doe'), 'JD');
    expect(initialsOf('john'), 'JO');
    expect(initialsOf('j'), 'J');
  });

  test('should ignore extra whitespaces', () {
    expect(initialsOf('John Doe '), 'JD');
    expect(initialsOf(' John Doe'), 'JD');
    expect(initialsOf('John  Doe'), 'JD');
    expect(initialsOf(' John  Doe '), 'JD');
    expect(initialsOf(' John '), 'JO');
    expect(initialsOf(' J '), 'J');
    expect(initialsOf(' '), '-');
    expect(initialsOf('  '), '-');
  });
}
