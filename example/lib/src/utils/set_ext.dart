extension SetUtil<E> on Set<E> {
  Set<E> concat(Set<E> another) {
    var copy = this.toSet();
    copy.addAll(another);
    return copy;
  }
}
 