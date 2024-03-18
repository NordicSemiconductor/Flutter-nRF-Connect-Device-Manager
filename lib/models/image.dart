import 'dart:typed_data';

class Image {
  int image;
  int slot;
  Uint8List hash;
  Uint8List data;

  Image({
    required this.image,
    required this.slot,
    required this.hash,
    required this.data,
  });
}
