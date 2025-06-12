
import '../../trees/heaps/heap_implementation.dart';

/// IMPLEMENTATION
/// Using Heap Class
List<E> heapsort<E extends Comparable<dynamic>>(List<E> list) {
  // Add a copy of the input list to a heap. Heap sorts this into a min-heap
  final heap = Heap<E>(initElements: list, priority: Priority.min);
  // Create an empty list to add the sorted values to
  final sorted = <E>[];
  // Keep removing the minimum value from the heap until it’s empty
  while (!heap.isEmpty) {
    final value = heap.remove();
    // Add the removed value to the empty list
    sorted.add(value!);
  }
  return sorted;
}

/// Using Sort-In Place
extension Heapsort<E extends Comparable<dynamic>> on List<E> {
  // 1. Add helper methods
  int _leftChildIndex(int parentIndex) {
    return 2 * parentIndex + 1;
  }
  int _rightChildIndex(int parentIndex) {
    return 2 * parentIndex + 2;
  }
  void _swapValues(int indexA, int indexB) {
    final temp = this[indexA];
    this[indexA] = this[indexB];
    this[indexB] = temp;
  }

  // 2. Add Sift Down method
  // start is the index of the node that you want to sift down within the heap.
  // end marks the end of the heap. This allows you to resize your heap while
  // maintaining the size of the list.
  void _siftDown({required int start, required int end}) {
    var parent = start;
    while (true) {
      final left = _leftChildIndex(parent);
      final right = _rightChildIndex(parent);
      var chosen = parent;
      // Checks if the left child and right child is within the bounds of the
      // heap and is larger than the parent. This implementation assumes a
      // max-heap
      if (left < end && this[left].compareTo(this[chosen]) > 0) {
        chosen = left;
      }
      if (right < end && this[right].compareTo(this[chosen]) > 0) {
        chosen = right;
      }
      if (chosen == parent) return;
      _swapValues(parent, chosen);
      // update the chosen value as the new parent and repeat loop till heap
      // rules are accurate
      parent = chosen;
    }
  }

  // 3. Add main sort function
  void heapsortInPlace() {
    if (isEmpty) return;
    // Heapify the list : turn the list into a max-heap
    final start = length ~/ 2 - 1;
    for (var i = start; i >= 0; i--) {
      _siftDown(start: i, end: length);
    }
    // Sort the list in ascending order. Do that by swapping the max value,
    // which is at the front of the list, with a smaller value at the end of
    // the heap. Sift that smaller value down to its proper location and repeat
    // each time moving the heap’s end index up by one to preserve the sorted
    // values at the end of the list.
    for (var end = length - 1; end > 0; end--) {
      _swapValues(0, end);
      _siftDown(start: 0, end: end);
    }
  }
}

/// CHALLENGE
/// 1. COMPARISON (max heap)
// Who needs less comparison between :
// (a) [1,2,3,4,5] and (b) [5,4,3,2,1]
// Ans: (b) because its sorted already compared to (a)

/// 2. DESCENDING ORDER
// 1. Using reversed
// print("using sort in place : ${list.reversed}");

// 2. Using Heap Class
// set priority to Priority.max

// 3. Using Heapsort In Place
// change the implementation in sift down from ">" to "<" to make it a min-heap