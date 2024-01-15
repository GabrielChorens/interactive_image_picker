import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_image_picker/interactive_image_picker.dart';

void main() {
  group('InteractiveImagePicker', () {
    testWidgets('should display placeholder when imageFileController is null',
        (WidgetTester tester) async {
      final imageFileController = ValueNotifier<File?>(null);
      await tester.pumpWidget(
        MaterialApp(
          home: InteractiveImagePicker(
            imageFileController: imageFileController,
            placeholder: const Icon(Icons.image),
          ),
        ),
      );

      expect(find.byIcon(Icons.image), findsOneWidget);
    });
  });
}
