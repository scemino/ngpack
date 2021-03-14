/// Represents an entry in a [GGPackDecoder].
class GGPackEntry {
  String filename;
  int offset;
  int size;

  GGPackEntry(this.filename, this.offset, this.size);

  @override
  String toString() {
    return '$filename (off: $offset, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    final entry = other as GGPackEntry?;
    if (entry == null) return false;
    return entry.filename == filename &&
        entry.offset == offset &&
        entry.size == size;
  }
}
