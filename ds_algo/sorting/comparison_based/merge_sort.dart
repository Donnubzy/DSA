
/// IMPLEMENTATION
/// Merging Lists
List<E> _merge<E extends Comparable<dynamic>>(List<E> listA, List<E> listB) {
  // indexA and indexB track your progress as you parse through the two lists
  var indexA = 0;
  var indexB = 0;
  final result = <E>[];
  // Starting from the beginning of listA and listB, you sequentially compare
  // the values. If you’ve reached the end of either list, there’s nothing else
  // to compare
  while (indexA < listA.length && indexB < listB.length) {
    final valueA = listA[indexA];
    final valueB = listB[indexB];
    // The smaller of the two values go into the result list
    if (valueA.compareTo(valueB) < 0) {
      result.add(valueA);
      indexA += 1;
    }
    else if (valueA.compareTo(valueB) > 0) {
      result.add(valueB);
      indexB += 1;
    }
    // If the values are equal, they can both be added
    else {
      result.add(valueA);
      result.add(valueB);
      indexA += 1;
      indexB += 1;
    }
  }
  // When there's nothing to compare but there are still values in either list,
  // add them all
  if (indexA < listA.length) {
    result.addAll(listA.getRange(indexA, listA.length));
  }

  if (indexB < listB.length) {
    result.addAll(listB.getRange(indexB, listB.length));
  }
  return result;
}

/// Splitting
List<E> mergeSort<E extends Comparable<dynamic>>(List<E> list) {
  // Here, the base case is when the list only has one element
  if (list.length < 2) {
    //print('recursion ending:  $list');
    return list;
  } else {
    //print('recursion list in: $list');
  }
  // You’re now recursively calling mergeSort on the left and right halves of
  // the original list.
  final middle = list.length ~/ 2;
  final left = mergeSort(list.sublist(0, middle));
  final right = mergeSort(list.sublist(middle));

  // This will combine the left and right lists that you split above
  final merged = _merge(left, right);
  //print('recursion ending:  merging $left and $right ->$merged');
  return merged;
}


/// CHALLENGE
/// Merging two Iterables
List<E> _mergeIterable<E extends Comparable<dynamic>>(
    Iterable<E> first, Iterable<E> second ) {

  var result = <E>[];
  // Use the "iterator" property to access the next & current value in iterable
  var firstIterator = first.iterator;
  var secondIterator = second.iterator;
  // Create two variables to keep track of when the iterators have reached the
  // end of their content. moveNext returns true if the iterator found a next
  // element, or false if the end of the collection was reached.
  var firstHasValue = firstIterator.moveNext();
  var secondHasValue = secondIterator.moveNext();

  while (firstHasValue && secondHasValue) {
    // Point to the values using the current property of your iterators
    final firstValue = firstIterator.current;
    final secondValue = secondIterator.current;
    // If the first value is less than the second one, add the first value to
    // result then move the iterator to the next value.
    if (firstValue.compareTo(secondValue) < 0) {
      result.add(firstValue);
      firstHasValue = firstIterator.moveNext();
    }
    // If the first value is greater than the second, do the opposite
    else if (firstValue.compareTo(secondValue) > 0) {
      result.add(secondValue);
      secondHasValue = secondIterator.moveNext();
    }
    // If both values are equal, add them both and move the iterators on
    else {
      result.add(firstValue);
      result.add(secondValue);
      firstHasValue = firstIterator.moveNext();
      secondHasValue = secondIterator.moveNext();
    }
  }
  if (firstHasValue) {
    do {
      result.add(firstIterator.current);
    }
    while (firstIterator.moveNext());
  }
  if (secondHasValue) {
    do {
      result.add(secondIterator.current);
    }
    while (secondIterator.moveNext());
  }
  return result;
}