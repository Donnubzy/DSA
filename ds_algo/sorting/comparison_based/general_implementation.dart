
/// O(n^2) sorting algorithms

/// Swap extension for List
extension SwappableList<E> on List<E> {
  void swap(int indexA, int indexB) {
    final temp = this[indexA];
    this[indexA] = this[indexB];
    this[indexB] = temp;
  }
}

/// [1] BUBBLE SORT
void bubbleSort<E extends Comparable<dynamic>>(List<E> list) {
  // The outer for loop counts the passes
  for (var end = list.length - 1; end > 0; end--) {
    var swapped = false;
    // The inner for loop handles the work of a single pass. It moves through
    // the indices, comparing adjacent values and swapping them if the first
    // value is larger than the second.
    for (var current = 0; current < end; current++) {
      if (list[current].compareTo(list[current + 1]) > 0) {
        list.swap(current, current + 1);
        swapped = true;
        //print(list);
      }
    }
    // If no values were swapped during a pass, the collection must be sorted
    if (!swapped) return;
  }
}

/// [2] SELECTION SORT
void selectionSort<E extends Comparable<dynamic>>(List<E> list) {
  // The outer for loop represents the passes, where start is the index the
  // current pass should begin at. Since the lowest value is moved to start at
  // the end of every pass, start increments by one each time, loop stops at
  // the index before the last because by then the sorting is complete
  for (var start = 0; start < list.length - 1; start++) {
    var lowest = start;
    // In every pass, you go through the remainder of the collection to find
    // the element with the lowest value.
    for (var next = start + 1; next < list.length; next++) {
      if (list[next].compareTo(list[lowest]) < 0) {
        lowest = next;
        //print(list);
      }
    }
    // If a lower value was found, swap it with the value at the start index
    if (lowest != start) {
      list.swap(lowest, start);
    }
  }
}

/// [3] INSERTION SORT
void insertionSort<E extends Comparable<dynamic>>(List<E> list) {
  // Outer loop iterates from left to right once. At the beginning of the loop,
  // current is the index of the element you want to sort in this pass.
  for (var current = 1; current < list.length; current++) {
    // Run backward from the current index so you can shift left as needed
    for (var shifting = current; shifting > 0; shifting--) {
      // Keep shifting the element left as long as necessary.
      if (list[shifting].compareTo(list[shifting - 1]) < 0) {
        list.swap(shifting, shifting - 1);
        //print(list);
      }
      // As soon as the element is in position, break the inner loop and start
      // with the next element.
      else {
        break;
      }
    }
  }
}