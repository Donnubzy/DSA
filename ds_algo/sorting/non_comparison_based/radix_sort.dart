
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
        //print(buckets);
        if (remainingPart ~/ base > 0) {
          done = false;
        }
      });
      place *= base;
      clear();
      // Since buckets is a list of lists, expand helps you flatten them back
      // into a single-dimensional list.
      addAll(buckets.expand((element) => element));
    }
  }
}