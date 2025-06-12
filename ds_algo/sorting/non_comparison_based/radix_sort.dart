
import 'dart:math';

/// Using the LEAST SIGNIFICANT DIGIT (LSD) to sort.
extension RadixSort on List<int> {
  void radixSort() {
    const base = 10;
    var done = false;
    // Loop through each place value, where place is first 1, then 10, then 100,
    // and so on through the largest place value in the list
    var place = 1;
    while (!done) {
      done = true;
      // Create your ten buckets.
      final buckets = List.generate(base, (_) => <int>[]);
      forEach((number) {
        // Find the significant digit of the current number
        final remainingPart = number ~/ place;
        final digit = remainingPart % base;
        // Put number in the appropriate position in bucket
        buckets[digit].add(number);
        if (remainingPart ~/ base > 0) {
          done = false;
        }
      });
      place *= base;
      clear();
      // Since buckets is a list of lists, expand helps you flatten them back
      // into a single-dimensional list.
      addAll(buckets.expand((element) => element));
      //print(buckets);
    }
  }
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
     // print(priorityBucket);
        continue;
      }
      buckets[digit].add(number);
    }
    // Reduce takes a collection and reduces it to a single value/list.
    // The values in that list will be numbers in the order that they came from
    // the buckets. reduce works by keeping a running result list which you can
    // add to based on the current bucket that you’re iterating to.
    // print(buckets);
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


/// CHALLENGE
/// Unique Characters
int uniqueCharacters(List<String> words) {
  final uniqueChars = <int>{};
  for (final word in words) {
    for (final codeUnit in word.codeUnits) {
      uniqueChars.add(codeUnit);
    }
  }
  return uniqueChars.length;
}

/// Optimization
extension RadixSorting on List<int> {
  // Heavily relies on the arrangement of the digits in the list
  void radixSortOptimized() {
    const base = 10;
    var place = 1;
    // Initialize the unsorted count with however many numbers are in the list.
    var unsorted = length;
    // Sort as long as there is more than one number left in the list to sort.
    while (unsorted > 1) {
      // Start the counting over at the beginning of each round.
      unsorted = 0;
      final buckets = List.generate(base, (_) => <int>[]);
      forEach((number) {
        final remainingPart = number ~/ place;
        final digit = remainingPart % base;
        buckets[digit].add(number);
        // If the current number has more significant digits left, then
        // increment the unsorted count.
        if (remainingPart ~/ base > 0) {
          unsorted++;
        }
      });
      place *= base;
      clear();
      addAll(buckets.expand((element) => element));
      //print(buckets);
    }
  }
}