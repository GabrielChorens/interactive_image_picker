part of '../interactive_image_picker.dart';

/// Function that takes the new photo taking in consideration what its displayed
/// on the card
Future<File> _cropSaveAndReturnImage({
  required BuildContext context,
  required File imageFile,
  required ScreenshotController screenshotController,
}) async {
  final path = imageFile.parent.path;
  final fileName = DateTime.now().microsecondsSinceEpoch.toString();

  final newImagePath = await screenshotController.captureAndSave(
    path,
    fileName: '$fileName.jpg',
    delay: const Duration(milliseconds: 10),
    //To maintain the same quality of the original image
    pixelRatio: View.of(context).devicePixelRatio,
  );
  if (newImagePath == null) {
    throw Exception('Error while saving image.');
  }
  return File(newImagePath);
}

//Styling helpers

Color _defaultForegroundColor(BuildContext context) =>
    Theme.of(context).colorScheme.outlineVariant;

Color _defaultBackgroundColor(BuildContext context) =>
    Theme.of(context).colorScheme.background;

IconData _defaultCameraIcon(IconData? userPromptedCameraIcon) =>
    userPromptedCameraIcon ?? Icons.camera_alt;

IconData _defaultGalleryIcon(IconData? userPromptedGalleryIcon) =>
    userPromptedGalleryIcon ?? Icons.photo_library;

IconData _defaultDoneButtonIcon(IconData? userPromptedDoneButtonIcon) =>
    userPromptedDoneButtonIcon ?? Icons.done;

BorderSide _defaultBorderSide(
  BuildContext context,
  BorderSide? userPromptedBorderSide,
) {
  final defaultBorderSide = BorderSide(
    color: _defaultForegroundColor(context),
  );

  if (userPromptedBorderSide == null) {
    return defaultBorderSide;
  } else {
    return userPromptedBorderSide;
  }
}

BorderRadius get _defaultBorderRadius => const BorderRadius.all(
      Radius.circular(30),
    );

ButtonStyle _defaultButtonStyle(
  BuildContext context,
  ButtonStyle? userPromptedStyle,
  BorderSide? userPromptedBorderSide,
) {
  final defaultButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      _defaultBackgroundColor(context),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      CircleBorder(
        side: _defaultBorderSide(context, userPromptedBorderSide),
      ),
    ),
    iconSize: MaterialStateProperty.all<double>(20),
    fixedSize: MaterialStateProperty.all<Size>(const Size(30, 30)),
    iconColor: MaterialStateProperty.all<Color>(
      _defaultForegroundColor(context),
    ),
  );

  if (userPromptedStyle == null) {
    return defaultButtonStyle;
  } else {
    return userPromptedStyle.merge(defaultButtonStyle);
  }
}
