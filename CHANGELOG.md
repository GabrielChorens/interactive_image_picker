## 1.0.0 - Initial Release

### Added
- InteractiveImagePicker widget that allows the user to select an image from the gallery or take a picture with the camera.
- User can adjust the image by zooming in and out and moving it around.
- Once the user is satisfied with the image, they can press the done button and the image will be cropped and saved.
- The ValueNotifier<File?> imageFileController will automatically update its value with the cropped image file.
- Customizable position of the buttons, the icons of the buttons, the style of the buttons, the border of the widget and the border radius of the widget.
- Default shape is a rounded rectangle, but a circular profile like shape can be used by using the InteractiveImagePicker circular constructor.
- Unit tests for the InteractiveImagePicker widget.