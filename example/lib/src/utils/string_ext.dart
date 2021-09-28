extension StringExt on String {
  String replaceIfEmpty(String replacer) {
    return this.isEmpty ? replacer : this;
  }
}
