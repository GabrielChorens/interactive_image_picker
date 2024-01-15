<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Interactive Image Picker

Interactive Image Picker is a Flutter widget that allows users to select an image from the gallery or take a photo with the camera. Users can adjust the selected image by zooming in and out and moving it around. Once the user is satisfied with the image, they can press the done button and the image will be automatically cropped and saved.

## Features

- Image selection from the gallery or camera.
- Adjustment of the selected image (zoom and movement).
- Automatic cropping and saving of the adjusted image.
- Customization of the button positions, button icons, button styles, widget border, and border radius.
- Default shape is a rounded rectangle, but a circular profile-like shape can be used by using the `InteractiveImagePicker.circular` constructor.

## Getting Started

To use this package, follow the instructions below.

### Dependency

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  interactive_image_picker: ^0.0.1
```

## Usage

```dart
class _InteractiveImagePickerExampleState
    extends State<InteractiveImagePickerExample> {
  final ValueNotifier<File?> imageFile = ValueNotifier<File?>(null);
  final ValueNotifier<File?> imageFile2 = ValueNotifier<File?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive image picker example'),
      ),
      body: Column(
        children: [
          Center(
            child: InteractiveImagePicker.circular(
              imageFileController: imageFile,
              placeholder: const Center(
                child: Text('No image selected'),
              ),
              width: 200,
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: InteractiveImagePicker(
              imageFileController: imageFile2,
              placeholder: const Center(
                child: Icon(Icons.image, size: 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

## Contributing

Contributions are welcome! If you find a bug, please report it. If you have a feature you'd like to see in the package, please open an issue. If you have the time to fix an issue or to add a new feature, please submit a pull request.
