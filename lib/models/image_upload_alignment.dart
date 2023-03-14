class ImageUploadAlignment {
  final int rawValue;

  const ImageUploadAlignment._(this.rawValue);

  static const ImageUploadAlignment disabled = const ImageUploadAlignment._(0);
  static const ImageUploadAlignment twoByte = const ImageUploadAlignment._(2);
  static const ImageUploadAlignment fourByte = const ImageUploadAlignment._(4);
  static const ImageUploadAlignment eightByte = const ImageUploadAlignment._(8);
  static const ImageUploadAlignment sixteenByte = const ImageUploadAlignment._(16);
}