import 'package:image_picker/image_picker.dart';

pickedImage(ImageSource imageSource) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: imageSource);
  if (file != null) {
    return await file.readAsBytes();
  }
  print("no selected image");
  return null;
}
