
import 'dart:math';

void main(){
  final list = [46, 500, 459, 1345, 13, 999];
  list.lexicographicalSort();
  print(list);
}

/// Using the MOST SIGNIFICANT DIGIT (MSD) to sort.
// A. Getting the number of digits
extension Digits on int {
  static const _base = 10;
  int digits() {
    var count = 0;
    var number = this;
    while (number != 0) {
      count += 1;
      // Number of times you have to divide the number by 10 before you get 0.
      number ~/= _base;
    }
    return count;
  }

  // B. Finding the digit at some position
  int? digitAt(int position) {
    if (position >= digits()) {
      return null;
    }
    var number = this;
    // condition checks the value of the preceding digit before the chosen
    // position
    while (number ~/ pow(_base, position + 1) != 0) {
      // updates the value of number by cutting the ending values till the
      // chosen position is the last digit or only digit left
      number ~/= _base;
      //print(number);
    }
    // returns the remainders value
    return number % _base;
  }
}

extension MsdRadixSort on List<int> {
  // C. Finding the max digits of an int in a list
  int maxDigits() {
    if (isEmpty) return 0;
    // returns the count of the max value in the list
    return reduce(max).digits();
  }
  // D. Recursive sort
  void lexicographicalSort() {
    final sorted = _msdRadixSorted(this, 0);
    // clear current values in the list
    clear();
    // add all the sorted values to the list
    addAll(sorted);
  }

  // E. Recursive sort helper method
  // The list that you pass to this recursive method will be the full list on
  // the first round (when position is 0), but after that, it’ll be the smaller
  // bucket lists
  List<int> _msdRadixSorted(List<int> list, int position) {
    // Base case : recursion stops if there’s only one element in the list or
    // if you’ve exceeded the max number of digits.
    if (list.length < 2 || position >= list.maxDigits()) {
      return list;
    }
    // Instantiate a two-dimensional list for the buckets
    final buckets = List.generate(10, (_) => <int>[]);
    // The priorityBucket is a special bucket that stores values with fewer
    // digits than the current position.
    var priorityBucket = <int>[];
    // For every number in the list, you find the digit at the current position
    // and use it to place the number in the appropriate bucket.
    for (var number in list) {
      final digit = number.digitAt(position);
      if (digit == null) {
        priorityBucket.add(number);
        continue;
      }
      buckets[digit].add(number);
    }
    // Reduce takes a collection and reduces it to a single value/list.
    // The values in that list will be numbers in the order that they came from
    // the buckets. reduce works by keeping a running result list which you can
    // add to based on the current bucket that you’re iterating to.
    final bucketOrder = buckets.reduce((result, bucket) {
      if (bucket.isEmpty) return result;
      // For every non-empty bucket that you come to, recursively sort that
      // bucket at the next digit position
      final sorted = _msdRadixSorted(bucket, position + 1);
      return result..addAll(sorted);
    });
    // Everything in the priority bucket goes first, but then add any other
    // values that were in the other buckets to the end of the list
    return priorityBucket..addAll(bucketOrder);
  }
}