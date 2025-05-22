
/// Dynamic List
class Stack<E>{
  Stack() : storage = <E>[];
  final List<E> storage;

  void push(E element) => storage.add(element);
  E pop() => storage.removeLast();
  E get peek => storage.last;
  int get size => storage.length;
  bool get isEmpty => storage.isEmpty;
  bool get isNotEmpty => !isEmpty;
}

/// Fixed List
class Stacks<E>{
  Stacks(this.cap) : top = -1, arr = List.filled(cap, 0);
  int cap, top;
  List<int> arr;

  void push(int x) => top >= cap - 1 ? print("Stack Error") : arr[++top] = x;
  int pop() => top < 0 ? 0 : arr[top--];
  int get peek => top < 0 ? 0 : arr[top];
  int get size => arr.length;
  bool get isEmpty => arr.isEmpty;
  bool get isNotEmpty => !isEmpty;
}
