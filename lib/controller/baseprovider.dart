import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class BaseProvider extends ChangeNotifier {
  File? selectedImage;
  ImagePicker imagePicker = ImagePicker();
  void setImage(ImageSource source) async {
    final pickedImage = await imagePicker.pickImage(source: source);

    selectedImage = pickedImage != null ? File(pickedImage.path) : null;
    notifyListeners();
  }
}
