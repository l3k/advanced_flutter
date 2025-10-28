import 'package:advanced_flutter/ui/components/player_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('should present initials when there is no photo', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: PlayerPhoto(initials: 'RO', photo: null)),
    );
    expect(find.text('RO'), findsOneWidget);
  });

  testWidgets('should hide initials when there is photo', (tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: PlayerPhoto(
            initials: 'RO',
            photo: 'http://example.com/photo.jpg',
          ),
        ),
      );
      expect(find.text('RO'), findsNothing);
    });
  });
}
