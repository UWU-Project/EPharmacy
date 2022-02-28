import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:pill_pal/model/data_layer.dart';
import 'package:pill_pal/repositories/exceptions.dart';

class MediaService {
  final ImagePicker _imagePicker = ImagePicker();
  ImageModel? image;

  Future<ImageModel?> pickImageFromGallery() async {
    try {
      final _image = await _imagePicker.pickImage(source: ImageSource.gallery);
      final image = ImageModel(imagePath: _image!.path);
      return image;
    } catch (e) {
      ImageNotSelectedException('Image not found');
    }
    // }
  }
}
