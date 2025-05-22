
// To select priority type
enum Priority { max, min }

class Heap<E extends Comparable<dynamic>> {
  Heap({List<E>? initElements, this.priority = Priority.max}) {
    // initElements : optional List in constructor to initialize heap with
    this.elements = (initElements == null) ? [] : initElements;
    buildHeap();
  }

  void buildHeap() {
    if (isEmpty) return;
    // Loop through only half of the elements because there’s no point in
    // sifting leaf nodes down
    final start = elements.length ~/ 2 - 1;
    // Loop through the list backwards, starting from the first non-leaf node
    for (var i = start; i >= 0; i--) {
      // Sift all parent nodes down
      _siftDown(i);
    }
  }

  late final List<E> elements;
  final Priority priority;

  @override
  String toString() => elements.toString();

  bool get isEmpty => elements.isEmpty;
  int get size => elements.length;
  E? get peek => (isEmpty) ? null : elements.first;

  /// Helper Methods
  // 1. Accessing the parent and child nodes
  int _leftChildIndex(int parentIndex) => 2 * parentIndex + 1;
  int _rightChildIndex(int parentIndex) => 2 * parentIndex + 2;
  int _parentIndex(int childIndex) => (childIndex - 1) ~/ 2;

  // 2. Selecting a Priority
  // method compares any two values
  bool _firstHasHigherPriority(E valueA, E valueB) {
    if (priority == Priority.max) {
      // first value must be larger than second value
      return valueA.compareTo(valueB) > 0;
    }
    return valueA.compareTo(valueB) < 0;
  }
  // method compares the values at two specific indices in the list
  int _higherPriority(int indexA, int indexB) {
    if (indexA >= elements.length) return indexB;
    final valueA = elements[indexA];
    final valueB = elements[indexB];
    final isFirst = _firstHasHigherPriority(valueA, valueB);
    return (isFirst) ? indexA : indexB;
  }

  // 3. Swapping values
  void _swapValues(int indexA, int indexB) {
    final temp = elements[indexA];
    // A becomes B
    elements[indexA] = elements[indexB];
    // B becomes former A
    elements[indexB] = temp;
  }

  /// Insert and upSift
  void insert(E value) {
    // add value to the end of the heap (via the list)
    elements.add(value);
    // sift up the value starting from its current index i.e last position in
    // the list
    _siftUp(elements.length - 1);
  }
  // method to swap parent and child indices
  void _siftUp(int index) {
    var child = index;
    var parent = _parentIndex(child);
    // as long as the child has higher priority than its parent and its not at
    // 0th index
    while (child > 0 && child == _higherPriority(child, parent)) {
      // swap the parent and child values
      _swapValues(child, parent);
      // update the values by moving up the heap tree
      child = parent;
      parent = _parentIndex(child);
    }
  }

  /// downSift and Remove from top of the heap
  void _siftDown(int index) {
    // Store the parent index to keep track of where you are in the traversal.
    var parent = index;
    while (true) {
      // Indices of the parent’s left and right children
      final left = _leftChildIndex(parent);
      final right = _rightChildIndex(parent);
      // The chosen variable is used to keep track of which index to swap with
      // the parent. If there’s a left child, and it has a higher priority than
      // its parent, make it the chosen one.
      var chosen = _higherPriority(left, parent);
      // If there’s a right child, and it has an even greater priority,
      // it will become the chosen one instead.
      chosen = _higherPriority(right, chosen);
      // If chosen is still parent, then no more sifting is required
      if (chosen == parent) return;
      // Else, swap chosen with parent,
      _swapValues(parent, chosen);
      // set it as the new parent, and continue sifting.
      parent = chosen;
    }
  }

  E? remove() {
    if (isEmpty) return null;
    // Swap the root with the last element in the heap
    _swapValues(0, elements.length - 1);
    // remove the last element and save a copy to be returned at the end of the
    // method (to show removed item)
    final value = elements.removeLast();
    // Perform a down sift to make sure it conforms to the rules
    _siftDown(0);
    return value;
  }

  /// Removing from an arbitrary index
  E? removeAt(int index) {
    final lastIndex = elements.length - 1;
    // Check if the index is within the bounds of the list. If not, return null.
    if (index < 0 || index > lastIndex) {
      return null;
    }
    // if index is the last element's index just simply remove it.
    if (index == lastIndex) {
      return elements.removeLast();
    }
    // Else, swap with last index and save a copy to return
    _swapValues(index, lastIndex);
    final value = elements.removeLast();
    // Perform a down sift and an up sift to adjust the heap
    _siftDown(index);
    _siftUp(index);
    return value;
  }

  /// Searching for the index of an element
  int indexOf(E value, {int index = 0}) {
    // if index is bigger than the length of the list
    if (index >= elements.length) {
      return -1;
    }
    // Check to see if the value you’re looking for has higher priority than
    // the current node at your recursive traversal of the tree. If it does,
    // the value you’re looking for cannot possibly be lower in the heap
    if (_firstHasHigherPriority(value, elements[index])) {
      return -1;
    }
    // If the value you’re looking for is equal to the value at current index,
    // Return the index
    if (value == elements[index]) {
      return index;
    }
    // perform recursion on the left child
    final left = indexOf(value, index: _leftChildIndex(index));
    if (left != -1) return left;
    // Else return index from the right child recursion
    return indexOf(value, index: _rightChildIndex(index));
  }

}