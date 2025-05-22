
extension SortedList<E extends Comparable<dynamic>> on List<E> {
  int? binarySearch(E value, [int? start, int? end]) {
    // First, you check if start and end are null. If so, you create a range
    // that covers the entire collection.
    final startIndex = start ?? 0;
    final endIndex = end ?? length;
    // Check if the range contains at least one element.If it does not,return null
    if (startIndex >= endIndex) {
      return null;
    }
    // Find the middle index of the range.
    final size = endIndex - startIndex;
    final middle = startIndex + size ~/ 2;
    // Compare the value at this index with the value that you’re searching for.
    // If the values match, you return the middle index.
    if (this[middle] == value) {
      return middle;
      // If not, you recursively search the left or right half of the collection.
    } else if (value.compareTo(this[middle]) < 0) {
      return binarySearch(value, startIndex, middle);
    } else {
      return binarySearch(value, middle + 1, endIndex);
    }
  }
}