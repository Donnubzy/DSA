
import '../../stacks/stack_implementation.dart';

extension Swappable<E> on List<E> {
  void swap(int indexA, int indexB) {
    if (indexA == indexB) return;
    final temp = this[indexA];
    this[indexA] = this[indexB];
    this[indexB] = temp;
  }
}

/// IMPLEMENTATION
/// A] NAIVE IMPLEMENTATION
List<E> quicksortNaive<E extends Comparable<dynamic>>(List<E> list) {
  // Only one element in the list means its sorted (BASE CASE)
  if (list.length < 2) return list;
  // Use the first element in the list as pivot
  final pivot = list[0];
  // Using the pivot, split the original list into three partitions
  final less = list.where((value) => value.compareTo(pivot) < 0);
  final equal = list.where((value) => value.compareTo(pivot) == 0);
  final greater = list.where((value) => value.compareTo(pivot) > 0);
  // Recursively sort the partitions and then combine them
  return [
    ...quicksortNaive(less.toList()),
    ...equal,
    ...quicksortNaive(greater.toList()),
  ];
}

/// B] LOMUTO'S PARTITIONING ALGORITHM
// low and high are the index values of the range that you want to partition
// within the list
int _partitionLomuto<T extends Comparable<dynamic>>(List<T> list, int low,
    int high) {
  // Lomuto always chooses the last element as the pivot
  final pivot = list[high];
  // pivotIndex will keep track of where the pivot value needs to go later
  var pivotIndex = low;
  // As you loop through the elements, you swap any value less than or equal to
  // the pivot with the value at the pivotIndex.
  for (int i = low; i < high; i++) {
    if (list[i].compareTo(pivot) <= 0) {
      list.swap(pivotIndex, i);
      pivotIndex += 1;
    }
  }
  // Once done with the loop, swap the value at pivotIndex with the pivot.
  list.swap(pivotIndex, high);
  return pivotIndex;
}

void quicksortLomuto<E extends Comparable<dynamic>>(List<E> list, int low,
    int high) {
  if (low >= high) return;
  // Apply Lomuto’s algorithm to partition the list into two regions.
  final pivotIndex = _partitionLomuto(list, low, high);
  // Recursively sort these regions
  quicksortLomuto(list, low, pivotIndex - 1);
  quicksortLomuto(list, pivotIndex + 1, high);
}

/// C] HOARE'S PARTITIONING ALGORITHM
int _partitionHoare<T extends Comparable<dynamic>>(List<T> list, int low,
    int high) {
  // Select the first element as the pivot value
  final pivot = list[low];
  // left and right pointers
  var left = low - 1;
  var right = high + 1;
  while (true) {
    // Keep increasing the left index until it comes to a value greater than or
    // equal to the pivot
    do {
      left += 1;
    }
    while (list[left].compareTo(pivot) < 0);
    // Keep decreasing the right index until it reaches a value that’s less
    // than or equal to the pivot.
    do {
      right -= 1;
    }
    while (list[right].compareTo(pivot) > 0);
    // Swap the values at left and right if they haven’t crossed yet
    if (left < right) {
      list.swap(left, right);
    }
    // Else return right as the new dividing index between the two partitions
    else {
      return right;
    }
  }
}

void quicksortHoare<E extends Comparable<dynamic>>(List<E> list, int low,
    int high) {
  if (low >= high) return;
  final leftHigh = _partitionHoare(list, low, high);
  quicksortHoare(list, low, leftHigh);
  quicksortHoare(list, leftHigh + 1, high);
}

/// D] MEDIAN OF THREE PARTITIONING ALGORITHM
int _medianOfThree<T extends Comparable<dynamic>>(List<T> list, int low,
    int high) {
  // find the center index
  final center = (low + high) ~/ 2;
  // find the median of list[low],list[center] and list[high]
  if (list[low].compareTo(list[center]) > 0) {
    list.swap(low, center);
  }
  if (list[low].compareTo(list[high]) > 0) {
    list.swap(low, high);
  }
  if (list[center].compareTo(list[high]) > 0) {
    list.swap(center, high);
  }
  return center;
}

void quicksortMedian<E extends Comparable<dynamic>>(List<E> list, int low,
    int high) {
  if (low >= high) return;
  // set the pivotIndex from the _medianOfThree function.
  var pivotIndex = _medianOfThree(list, low, high);
  // Since Lomuto's partitioning requires pivot to be at high, swap pivotIndex
  // position with high.
  list.swap(pivotIndex, high);
  pivotIndex = _partitionLomuto(list, low, high);
  quicksortLomuto(list, low, pivotIndex - 1);
  quicksortLomuto(list, pivotIndex + 1, high);
}

/// E] DUTCH NATIONAL FLAG PARTITIONING ALGORITHM
// To keep track of the entire range of the pivot partition not a single index
class Range {
  const Range(this.low, this.high);
  final int low;
  final int high;
}

Range _partitionDutchFlag<T extends Comparable<dynamic>>(List<T> list,
    int low, int high) {
  // Last value is set as the pivot here
  final pivot = list[high];
  // start positions of the pointers for the partitioning
  var smaller = low;
  var equal = low;
  var larger = high;
  while (equal <= larger) {
    // Compare the value at equal with the pivot value. Swap it into the correct
    // partition if needed and advance the appropriate pointers.
    if (list[equal].compareTo(pivot) < 0) {
      list.swap(smaller, equal);
      smaller += 1;
      equal += 1;
    } else if (list[equal] == pivot) {
      equal += 1;
    } else {
      list.swap(equal, larger);
      larger -= 1;
    }
  }
  // return a range of values that point to the first and last elements of the
  // middle partition (pivot partition).
  return Range(smaller, larger);
}

void quicksortDutchFlag<E extends Comparable<dynamic>>(List<E> list,
    int low, int high) {
  if (low >= high) return;
  // range of values in the middle(white)
  final middle = _partitionDutchFlag(list, low, high);
  // sorting the smaller values(orange)
  quicksortDutchFlag(list, low, middle.low - 1);
  // sorting the larger values(blue)
  quicksortDutchFlag(list, middle.high + 1, high);
}


/// CHALLENGE
/// 1. ITERATIVE QUICKSORT
void quicksortIterativeLomuto<E extends Comparable<dynamic>>(List<E> list) {
  // Create a stack that stores indices
  var stack = Stack<int>();
  // Push the starting low and high boundaries on the stack as initial values.
  stack.push(0);
  stack.push(list.length - 1);
  // When the stack is empty, quicksort is complete
  while (stack.isNotEmpty) {
    // Get the pair of high and low indices from the stack
    final high = stack.pop();
    final low = stack.pop();
    // Perform Lomuto’s partitioning with the current indices.
    final pivot = _partitionLomuto(list, low, high);
    // Once the partitioning is complete, add the lower bound’s low and high
    // indices to partition the lower half later
    if (pivot - 1 > low) {
      stack.push(low);
      stack.push(pivot - 1);
    }
    // Similarly, add the upper bound’s low and high indices to partition the
    // upper half later.
    if (pivot + 1 < high) {
      stack.push(pivot + 1);
      stack.push(high);
    }
  }
}