part of '../interactive_image_picker.dart';

class _EditingMode extends StatefulWidget {
  const _EditingMode({
    required this.imageFile,
    required this.width,
    required this.height,
    required this.borderSide,
    required this.borderRadius,
    required this.doneButtonIcon,
    required this.doneButtonStyle,
    this.rectangular = true,
    this.doneButtonPositionBuilder,
  });
  final ValueNotifier<File?> imageFile;

  final double width;
  final double height;

  final BorderSide borderSide;
  final BorderRadius borderRadius;

  final bool rectangular;

  final Positioned Function({
    required Widget child,
  })? doneButtonPositionBuilder;
  final IconData doneButtonIcon;
  final ButtonStyle doneButtonStyle;

  @override
  State<_EditingMode> createState() => _EditingModeState();
}

class _EditingModeState extends State<_EditingMode> {
  PhotoViewControllerBase controller = PhotoViewController();
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Should not happen
    if (widget.imageFile.value == null) {
      throw Exception('Image file is null.');
    }
    return ValueListenableBuilder(
      valueListenable: widget.imageFile,
      builder: (context, imageFile, _) {
        return Stack(
          children: [
            //ClipRect is used to prevent the image from overflowing the card
            ClipRect(
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: widget.rectangular
                    ? RoundedRectangleBorder(
                        side: widget.borderSide,
                        borderRadius: widget.borderRadius,
                      )
                    : CircleBorder(
                        side: widget.borderSide,
                      ),
                //The screenshot controller is used to crop the image
                child: Screenshot(
                  controller: screenshotController,
                  child: SizedBox(
                    width: widget.width,
                    height: widget.height,
                    //The PhotoView widget is used to zoom in and out of the image
                    child: PhotoView(
                      imageProvider: FileImage(imageFile!),
                      controller: controller,
                      tightMode: true,
                      minScale: PhotoViewComputedScale.contained,
                      backgroundDecoration: BoxDecoration(
                        color: _defaultBackgroundColor(context),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //If and else to allow the developer for customization
            if (widget.doneButtonPositionBuilder != null)
              widget.doneButtonPositionBuilder!(
                child: IconButton(
                  onPressed: () async => _getOnPressedFunction(
                    context: context,
                    imageFile: imageFile,
                    screenshotController: screenshotController,
                  ),
                  icon: Icon(widget.doneButtonIcon),
                  style: widget.doneButtonStyle,
                ),
              )
            else
              Positioned(
                bottom: 8,
                right: 16,
                child: IconButton(
                  onPressed: () async => _getOnPressedFunction(
                    context: context,
                    imageFile: imageFile,
                    screenshotController: screenshotController,
                  ),
                  icon: Icon(widget.doneButtonIcon),
                  style: widget.doneButtonStyle,
                ),
              ),
          ],
        );
      },
    );
  }

  ///Crops the image, saves it to the device and returns it.
  ///
  /// Resets the controller's scale and position.
  Future<void> _getOnPressedFunction({
    required BuildContext context,
    required File imageFile,
    required ScreenshotController screenshotController,
  }) async {
    final croppedImage = await _cropSaveAndReturnImage(
      context: context,
      imageFile: imageFile,
      screenshotController: screenshotController,
    );
    widget.imageFile.value = croppedImage;
    controller
      ..scale = 1.0
      ..position = Offset.zero;
  }
}
