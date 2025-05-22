
import '../../trees/heaps/heap_implementation.dart';
import '../queue_implementation.dart';


// When you use your priority queue in the future to implement Dijkstra’s
// algorithm, exporting Priority here will save you from having to import
// heap.dart separately.
export '../../trees/heaps/heap_implementation.dart' show Priority;

class PriorityQueue<E extends Comparable<dynamic>> implements Queue<E> {
  PriorityQueue({List<E>? elements, Priority priority = Priority.max}) {
    // convert list in constructor to a heap based on set priority
    _heap = Heap<E>(initElements: elements, priority: priority);
  }
  // Heap to implement the priority queue
  late Heap<E> _heap;

  @override
  bool get isEmpty => _heap.isEmpty;

  @override
  E? get peek => _heap.peek;

  @override
  bool enqueue(E element) {
    _heap.insert(element);
    return true;
  }

  @override
  E? dequeue() => _heap.remove();
}