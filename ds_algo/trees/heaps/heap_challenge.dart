

import 'heap_implementation.dart';

/// 1. Find the Nth smallest integer in an unsorted List
int? getNthSmallestElement(int n, List<int> elements) {
  // heap variable to convert unsorted list to heap with priority set as min
  var heap = Heap( initElements: elements, priority: Priority.min);
  int? value;
  // Iterate through the list till the nth element
  for (int i = 0; i < n; i++) {
    // remove the last element after the iteration
    value = heap.remove();
  }
  return value;
}

/// 2. Combine two Heaps
extension mergeLists<E extends Comparable<dynamic>> on Heap{
  void merge(List<E> list){
    // combine both lists
    elements.addAll(list);
    // build the heap tree from the merged lists
    buildHeap();
  }
}

/// 3. Is the List a Min heap?
bool isMinHeap<E extends Comparable<dynamic>>(List<E> elements) {
  // If the list is empty, it’s a min-heap
  if (elements.isEmpty) return true;
  // Loop through all parent nodes in the list in reverse order
  final start = elements.length ~/ 2 - 1;
  for (var i = start; i >= 0; i--) {
    // Get the left and right child indices.
    final left = 2 * i + 1;
    final right = 2 * i + 2;
    // Check to see if the left element is less than the parent
    if (elements[left].compareTo(elements[i]) < 0) {
      return false;
    }
    // Check to see if the right index is within the list’s bounds, and then
    // check if the right element is less than the parent.
    if (right < elements.length &&
        elements[right].compareTo(elements[i]) < 0) {
      return false;
    }
  }
  // If every parent-child relationship satisfies the min-heap property,
  return true;
}