
/// 1. Binary Search as a Free Function
int? searchIndex<E extends Comparable<dynamic>, T extends Iterable<E>>(
    E value, T arr, [int? first, int? last]){
  final firstIndex = first ?? 0;
  final lastIndex = last ?? arr.length;
  if(firstIndex >= lastIndex){
    return null;
  }
  final size = lastIndex - firstIndex;
  final midIndex = firstIndex + size ~/ 2;
  if(arr.elementAt(midIndex) == value){
    return midIndex;
  }
  else if(value.compareTo(arr.elementAt(midIndex)) < 0){
    return searchIndex(value, arr, firstIndex, midIndex);
  }
  else{
    return searchIndex(value, arr, midIndex + 1, lastIndex);
  }
}

/// 2. Binary Search as a non-recursive Function
int? binarySearch<E extends Comparable<dynamic>>(List<E> list, E value) {
  var start = 0;
  var end = list.length;
  while (start < end) {
    final middle = start + (end - start) ~/ 2;
    if (value == list[middle]) {
      return middle;
    }
    else if (value.compareTo(list[middle]) < 0) {
      end = middle;
    }
    else {
      start = middle + 1;
    }
  }
  return null;
}

/// 3. Searching for a Range
class Range {
  Range(this.start, this.end);
  final int start;
  final int end;

  @override
  String toString() => 'Range($start, $end)';
}

// Create a start index
int? _startIndex(List<int> list, int value) {
  if (list[0] == value) return 0;
  var start = 1;
  var end = list.length;
  while (start < end) {
    var middle = start + (end - start) ~/ 2;
    if (list[middle] == value && list[middle - 1] != value) {
      return middle;
    }
    else if (list[middle] < value) {
      start = middle + 1;
    }
    else {
      end = middle;
    }
  }
  return null;
}

// Create an end index
int? _endIndex(List<int> list, int value) {
  if (list[list.length - 1] == value) return list.length;
  var start = 0;
  var end = list.length - 1;
  while (start < end) {
    var middle = start + (end - start) ~/ 2;
    if (list[middle] == value && list[middle + 1] != value) {
      return middle + 1;
    } else if (list[middle] < value) {
      start = middle + 1;
    } else {
      end = middle;
    }
  }
  return null;
}

// find the range
Range? findRange(List<int> list, int value) {
  if (list.isEmpty) return null;
  final start = _startIndex(list, value);
  final end = _endIndex(list, value);
  // if either var(start/end) is null, then the entire range is null.
  if (start == null || end == null) return null;
  return Range(start, end);
}