library interactive_image_picker;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:screenshot/screenshot.dart';

part 'src/view_mode.dart';
part 'src/edit_mode.dart';
part 'src/utils.dart';

/// InteractiveImagePicker is a widget that allows the user to select an image
/// from the gallery or take a picture with the camera.
///
/// Later, the user can adjust the image by zooming in and out and moving it
/// around. Once the user is satisfied with the image, they can press the
/// done button and the image will be cropped and saved.
class InteractiveImagePicker extends StatefulWidget {
  /// InteractiveImagePicker is a widget that allows the user to select an image
  /// from the gallery or take a picture with the camera.
  ///
  /// Later, the user can adjust the image by zooming in and out and moving it
  /// around. Once the user is satisfied with the image, they can press the
  /// done button and the image will be cropped and saved.
  ///
  /// The ValueNotifier<File?> imageFileController will automatically update its
  /// value with the cropped image file.
  ///
  /// It allows you to customize the position of the buttons, the icons of the
  /// buttons, the style of the buttons, the border of the widget and the
  /// border radius of the widget.
  ///
  /// Its default shape is a rounded rectangle, but you can use a circular profile like shape
  /// by using the [InteractiveImagePicker.circular] constructor.
  const InteractiveImagePicker({
    required this.imageFileController,
    required this.placeholder,
    super.key,
    this.width = double.infinity,
    this.height = 200,
    this.borderSide,
    this.borderRadius,
    this.cameraButtonPositionBuilder,
    this.galleryButtonPositionBuilder,
    this.cameraIcon,
    this.galleryIcon,
    this.doneButtonPositionBuilder,
    this.doneButtonIcon,
    this.buttonsStyle,
  }) : _roundedRectangle = true;

  /// InteractiveImagePicker is a widget that allows the user to select an image
  /// from the gallery or take a picture with the camera.
  ///
  /// Later, the user can adjust the image by zooming in and out and moving it
  /// around. Once the user is satisfied with the image, they can press the
  /// done button and the image will be cropped and saved.
  ///
  /// The ValueNotifier<File?> imageFileController will automatically update its
  /// value with the cropped image file.
  ///
  /// It allows you to customize the position of the buttons, the icons of the
  /// buttons, the style of the buttons, the border of the widget and the
  /// border radius of the widget.
  ///
  /// Its default shape is a rounded rectangle, but you can use a circular profile like shape
  /// by using the [InteractiveImagePicker.circular] constructor.
  const InteractiveImagePicker.circular({
    required this.imageFileController,
    required this.placeholder,
    super.key,
    this.width,
    this.height,
    this.borderSide,
    this.borderRadius,
    this.cameraButtonPositionBuilder,
    this.galleryButtonPositionBuilder,
    this.doneButtonPositionBuilder,
    this.cameraIcon,
    this.galleryIcon,
    this.doneButtonIcon,
    this.buttonsStyle,
  }) : _roundedRectangle = false;

  ///Controller that handles the image file. In here you can get
  ///the cropped image file.
  ///
  /// Its recommended to initialize it with null.
  ///
  /// ```dart
  /// final ValueNotifier<File?> imageFileController = ValueNotifier<File?>(null);
  /// ```
  ///
  /// Once the user has selected an image and adjusted it, the controller will
  /// automatically update its value.
  ///
  /// This format of controller using ValueNotifier has multiple advantages since you
  /// may want to automatically update the UI when the image is selected or do
  /// something else with the image file in reaction to the user selecting it.
  final ValueNotifier<File?> imageFileController;

  /// Width of the widget. Defaults to MediaQuery.of(context).size.width.
  final double? width;

  /// Height of the widget. Defaults to [200].
  final double? height;

  /// Placeholder widget that will be displayed when no image is selected. It can be
  /// any widget. But, it is recommended to use a widget that has the same size as
  /// the widget itself.
  ///
  /// I would recommend using another image, or an icon or a text.
  final Widget placeholder;

  /// Border of the widget. Defaults to Border.all(color: Theme.of(context).colorScheme.outlineVariant).
  final BorderSide? borderSide;

  /// Border radius of the widget. Defaults to BorderRadius.all(Radius.circular(30)).
  final BorderRadius? borderRadius;

  //Used only through the circular constructor
  final bool _roundedRectangle;

  /// Position of the camera button. Defaults to the bottom right corner on the rectangular constructor
  /// and the bottom center on the circular constructor.
  ///
  /// child is the camera button widget.
  final Positioned Function({
    required Widget child,
  })? cameraButtonPositionBuilder;

  /// Position of the gallery button. Defaults to the bottom right corner on the rectangular constructor
  /// and the bottom center on the circular constructor.
  ///
  /// child is the gallery button widget.
  final Positioned Function({
    required Widget child,
  })? galleryButtonPositionBuilder;

  /// Position of the done button. Defaults to the bottom right corner.
  ///
  /// child is the done button widget.
  final Positioned Function({
    required Widget child,
  })? doneButtonPositionBuilder;

  /// Icon of the camera button. Defaults to Icons.camera_alt.
  final IconData? cameraIcon;

  /// Icon of the gallery button. Defaults to Icons.photo_library.
  final IconData? galleryIcon;

  /// Icon of the done button. Defaults to Icons.done.
  final IconData? doneButtonIcon;

  /// Style of the buttons. Defaults to a style that has a background color of Theme.of(context).colorScheme.background
  final ButtonStyle? buttonsStyle;

  @override
  State<InteractiveImagePicker> createState() =>
      _InteractiveImagePickerStateState();
}

class _InteractiveImagePickerStateState extends State<InteractiveImagePicker> {
  final ValueNotifier<bool> isViewMode = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();

    ///Automatically switch between view mode and edit mode when the imageFileController
    ///updates its value.
    widget.imageFileController.addListener(() {
      if (widget.imageFileController.value != null) {
        isViewMode.value = !isViewMode.value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ValueListenableBuilder(
        valueListenable: isViewMode,
        builder: (context, isViewMode, _) {
          return isViewMode
              ? _ViewMode(
                  imageFileController: widget.imageFileController,
                  placeholder: widget.placeholder,
                  width: widget.width ?? MediaQuery.of(context).size.width,
                  height: widget.height ?? 200,
                  cameraButtonPositionBuilder:
                      widget.cameraButtonPositionBuilder,
                  galleryButtonPositionBuilder:
                      widget.galleryButtonPositionBuilder,
                  cameraIcon: _defaultCameraIcon(
                    widget.cameraIcon,
                  ),
                  galleryIcon: _defaultGalleryIcon(
                    widget.galleryIcon,
                  ),
                  buttonsStyle: _defaultButtonStyle(
                    context,
                    widget.buttonsStyle,
                    widget.borderSide,
                  ),
                  borderSide: _defaultBorderSide(context, widget.borderSide),
                  borderRadius: widget.borderRadius ?? _defaultBorderRadius,
                  rectangular: widget._roundedRectangle,
                )
              : _EditingMode(
                  imageFile: widget.imageFileController,
                  width: widget.width ?? MediaQuery.of(context).size.width,
                  height: widget.height ?? 200,
                  doneButtonPositionBuilder: widget.doneButtonPositionBuilder,
                  doneButtonIcon: _defaultDoneButtonIcon(
                    widget.doneButtonIcon,
                  ),
                  doneButtonStyle: _defaultButtonStyle(
                    context,
                    widget.buttonsStyle,
                    widget.borderSide,
                  ),
                  borderSide: _defaultBorderSide(context, widget.borderSide),
                  borderRadius: widget.borderRadius ?? _defaultBorderRadius,
                  rectangular: widget._roundedRectangle,
                );
        },
      ),
    );
  }

  @override
  void dispose() {
    isViewMode.dispose();
    super.dispose();
  }
}
