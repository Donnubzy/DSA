
import '../linked_lists/doubly_linked_list_implementation.dart';
import 'queue_implementation.dart';

/// 3. Monopoly Board Game (Player turns)
extension BoardGameManager<E> on QueueRingBuffer {
  E? nextPlayer() {
    final person = dequeue();
    // check if an element has been dequeued before
    if (person != null) {
      // re-enqueue the formerly dequeued elements accordingly.
      enqueue(person);
    }
    return person;
  }
}

/// Double-ended Queue (DEQUE)
enum Direction { front, back }

abstract class Deque<E> {
  bool get isEmpty;
  E? peek(Direction from);
  bool enqueue(E element, Direction to);
  E? dequeue(Direction from);
}

// Using LinkedList as storage
class DequeDoublyLinkedList<E> implements Deque<E> {
  final _list = DoublyLinkedList<E>();

  @override
  String toString() => _list.toString();

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  E? peek(Direction from) {
    switch (from) {
      case Direction.front:
        return _list.head?.value;
      case Direction.back:
        return _list.tail?.value;
    }
  }

  @override
  bool enqueue(E value, Direction to) {
    switch (to) {
      case Direction.front:
        _list.push(value);
        break;
      case Direction.back:
        _list.append(value);
        break;
    }
    return true;
  }

  @override
  E? dequeue(Direction from) {
    switch (from) {
      case Direction.front:
        return _list.pop();
      case Direction.back:
        return _list.removeLast();
    }
  }
}