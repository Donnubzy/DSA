
import '../queue_implementation.dart';

/// 1. Prioritize a WaitList
/// By military status first, then age.
// Person must be comparable because the generic type(E) for priority queues
// is comparable
class Person implements Comparable<dynamic>{
  Person({required this.name, required this.age, required this.isMilitary});
  final String name;
  final int age;
  final bool isMilitary;

  @override
  int compareTo(other) {
    // if military status of the compared items is same
    if (isMilitary == other.isMilitary) {
      // use seniority(by age) for priority
      return age.compareTo(other.age);
    }
    // Else give priority to military personnel first
    return isMilitary ? 1 : -1;
  }

  @override
  String toString() {
    final military = (isMilitary) ? ', (military)' : '';
    return '$name, age $age$military';
  }
}

// in Main()
// final p1 = Person(name: 'Josh', age: 21, isMilitary: true);
// final p2 = Person(name: 'Jake', age: 22, isMilitary: true);
// final p3 = Person(name: 'Clay', age: 28, isMilitary: false);
// final p4 = Person(name: 'Cindy', age: 28, isMilitary: false);
// final p5 = Person(name: 'Sabrina', age: 30, isMilitary: false);
// final waitList = [p1, p2, p3, p4, p5];
//
// var priorityQueue = PriorityQueue(elements: waitList);
// while (!priorityQueue.isEmpty) {
// print(priorityQueue.dequeue());
// }

/// 2. List-Based Priority Queue
/// Setting the element with the highest priority at the back
enum Priority { max, min }

class PriorityQueueList<E extends Comparable<dynamic>> implements Queue<E> {
  PriorityQueueList({List<E>? elements, Priority priority = Priority.max}) {
    _priority = priority;
    _elements = elements ?? [];
    // sort helps to arrange the elements in the list
    _elements.sort((a, b) => _compareByPriority(a, b));
  }
  int _compareByPriority(E a, E b) {
    if (_priority == Priority.max) {
      return a.compareTo(b);
    }
    return b.compareTo(a);
  }

  late List<E> _elements;
  late Priority _priority;

  @override
  String toString() => _elements.toString();

  @override
  bool get isEmpty => _elements.isEmpty;

  @override
  E? get peek => (isEmpty) ? null : _elements.last;

  @override
  E? dequeue() => isEmpty ? null : _elements.removeLast();

  @override
  bool enqueue(E element) {
    // loop from low priority end of the list to high
    for (int i = 0; i < _elements.length; i++) {
      // Check to see if the element you’re adding has an even lower priority
      // than the current element
      if (_compareByPriority(element, _elements[i]) < 0) {
        // If it does, insert the new element at the current index
        _elements.insert(i, element);
        return true;
      }
    }
    // If you get to the end of the list, that means every other element was
    // lower priority. Add the new element to the end of the list as the new
    // highest priority element.
    _elements.add(element);
    return true;
  }

}