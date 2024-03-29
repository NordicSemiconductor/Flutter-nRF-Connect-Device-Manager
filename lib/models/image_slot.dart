part of mcumgr_flutter;

class ImageSlot {
  final int image;
  final int slot;
  final String? version;
  final Uint8List hash;
  final bool bootable;
  final bool pending;
  final bool confirmed;
  final bool active;
  final bool permanent;

  String get hashString =>
      hash.map((e) => e.toRadixString(16).padLeft(2, '0')).join();

  ImageSlot({
    required this.image,
    required this.slot,
    this.version,
    required this.hash,
    required this.bootable,
    required this.pending,
    required this.confirmed,
    required this.active,
    required this.permanent,
  });
}