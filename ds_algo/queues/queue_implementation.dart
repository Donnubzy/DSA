
import '../linked_lists/doubly_linked_list_implementation.dart'
    hide LinkedList;
import '../linked_lists/singly_linked_list_implementation.dart';
import 'ring_buffer.dart';

abstract class Queue<E>{
  bool enqueue(E element);
  E? dequeue();
  bool get isEmpty;
  E? get peek;
}

/// CREATING QUEUES USING DATA STRUCTURES
// 1. LIST-BASED IMPLEMENTATION
class QueueList<E> implements Queue<E> {
  final _list = <E>[];

  @override
  String toString() => _list.toString();

  @override
  bool enqueue(E element) {
    _list.add(element); // O(1)
    return true;
  }
  @override
  E? dequeue() => (isEmpty) ? null : _list.removeAt(0); // O(n)
  @override
  bool get isEmpty => _list.isEmpty; // O(1)
  @override
  E? get peek => (isEmpty) ? null : _list.first; // O(1)
}

// 2. LINKED LIST-BASED IMPLEMENTATION
class QueueLinkedList<E> implements Queue<E> {
  // for singly linked list
  final _linkedList = LinkedList();
  // for doubly linked list
  final _doublyLinkedList = DoublyLinkedList<E>();

  @override
  String toString() => _linkedList.toString();

  @override
  bool enqueue(E element) {
    _linkedList.append(element); // O(1)
    return true;
  }
  @override
  E? dequeue() => (isEmpty) ? null : _linkedList.pop(); // O(1)
  @override
  bool get isEmpty => _linkedList.isEmpty; // O(1)
  @override
  E? get peek => (isEmpty) ? null : _linkedList.head?.value; // O(1)
}

// 3. RING BUFFER-BASED IMPLEMENTATION
class QueueRingBuffer<E> implements Queue<E> {
  QueueRingBuffer(int length) : _ringBuffer = RingBuffer<E>(length);
  final RingBuffer<E> _ringBuffer;

  @override
  String toString() => _ringBuffer.toString();

  @override
  bool enqueue(E element) {
    if (_ringBuffer.isFull) {
      return false;
    }
    _ringBuffer.write(element); // O(1)
    return true;
  }
  @override
  E? dequeue() => _ringBuffer.read(); // O(1)
  @override
  bool get isEmpty => _ringBuffer.isEmpty; // O(1)
  @override
  E? get peek => _ringBuffer.peek; // O(1)
}

// 4. DOUBLE STACK IMPLEMENTATION
class QueueStack<E> implements Queue<E> {
  final _leftStack = <E>[];
  final _rightStack = <E>[];

  @override
  String toString() {
    final combined = [..._leftStack.reversed, ..._rightStack,].join(', ');
    return '[$combined]';
  }

  @override
  bool enqueue(E element) {
    _rightStack.add(element);
    return true;
  }
  @override
  E? dequeue() {
    if (_leftStack.isEmpty) {
      // If the left stack is empty, set it as the reverse of the right stack
      _leftStack.addAll(_rightStack.reversed);
      // Invalidate your right stack
      _rightStack.clear();
    }
    // If nothing is added from the right stack
    if (_leftStack.isEmpty) return null;
    // Remove the last element from the left stack
    return _leftStack.removeLast();
  }
  @override
  bool get isEmpty => _leftStack.isEmpty && _rightStack.isEmpty;
  @override
  E? get peek => _leftStack.isNotEmpty ? _leftStack.last : _rightStack.first;

  int get length => _leftStack.length + _rightStack.length;
}
