import 'dart:typed_data';

import '../proto/flutter_mcu.pb.dart';

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

  factory Image.fromProto(ProtoImage image) {
    return Image(
      image: image.image,
      slot: image.slot,
      hash: Uint8List.fromList(image.hash),
      data: Uint8List.fromList(image.data),
    );
  }

  ProtoImage toProto() {
    return ProtoImage(
      image: image,
      slot: slot,
      hash: hash.toList(),
      data: data.toList(),
    );
  }
}
