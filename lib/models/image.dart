part of mcumgr_flutter;

class Image {
  int image;
  int? slot;
  Uint8List? hash;
  Uint8List data;

  Image({
    required this.image,
    this.slot,
    this.hash,
    required this.data,
  });
}
