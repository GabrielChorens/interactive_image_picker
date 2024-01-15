part of '../interactive_image_picker.dart';

class _ViewMode extends StatelessWidget {
  const _ViewMode({
    required this.imageFileController,
    required this.borderSide,
    required this.borderRadius,
    required this.placeholder,
    required this.width,
    required this.height,
    required this.rectangular,
    required this.cameraIcon,
    required this.galleryIcon,
    required this.buttonsStyle,
    this.cameraButtonPositionBuilder,
    this.galleryButtonPositionBuilder,
  });

  final ValueNotifier<File?> imageFileController;
  final Widget placeholder;
  final double width;
  final double height;

  final BorderSide borderSide;
  final BorderRadius borderRadius;

  final bool rectangular;

  final Positioned Function({
    required Widget child,
  })? cameraButtonPositionBuilder;
  final Positioned Function({
    required Widget child,
  })? galleryButtonPositionBuilder;
  final IconData cameraIcon;
  final IconData galleryIcon;
  final ButtonStyle buttonsStyle;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: imageFileController,
      builder: (context, imageFile, _) {
        return Stack(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              shape: rectangular
                  ? RoundedRectangleBorder(
                      side: borderSide,
                      borderRadius: borderRadius,
                    )
                  : CircleBorder(
                      side: borderSide,
                    ),
              child: SizedBox(
                width: width,
                height: height,
                child: imageFile == null
                    ? placeholder
                    : Image.file(
                        imageFile,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            if (cameraButtonPositionBuilder != null)
              cameraButtonPositionBuilder!(
                child: IconButton(
                  onPressed: () async {
                    await _pickImage(ImageSource.camera);
                  },
                  icon: Icon(cameraIcon),
                  style: buttonsStyle,
                ),
              )
            else
              Positioned(
                bottom: 8,
                right: 16,
                child: IconButton(
                  onPressed: () async {
                    await _pickImage(ImageSource.camera);
                  },
                  icon: Icon(cameraIcon),
                  style: buttonsStyle,
                ),
              ),
            if (galleryButtonPositionBuilder != null)
              galleryButtonPositionBuilder!(
                child: IconButton(
                  onPressed: () async {
                    await _pickImage(ImageSource.gallery);
                  },
                  icon: Icon(galleryIcon),
                  style: buttonsStyle,
                ),
              )
            else
              Positioned(
                bottom: 8,
                right: rectangular ? 64 : null,
                left: rectangular ? null : 16,
                child: IconButton(
                  onPressed: () async {
                    await _pickImage(ImageSource.gallery);
                  },
                  icon: Icon(galleryIcon),
                  style: buttonsStyle,
                ),
              ),
          ],
        );
      },
    );
  }

  //Image picker abbreviation
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      imageFileController.value = File(pickedFile.path);
    }
  }
}
