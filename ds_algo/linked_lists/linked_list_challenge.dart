
import 'singly_linked_list_implementation.dart';

/// 1. Printing the reverse of a linkedList
// A. Using a temporary list
void reverseLinkedList(LinkedList list){
  LinkedList linkedList = LinkedList();
  for(int i in list){
    linkedList.push(i);
  }
  while(!linkedList.isEmpty){
    print(linkedList.pop());
  }
}

// B. Using recursion
void printNodesRecursively<T>(Node<T>? node) {
  // base case (to stop recursion)
  if (node == null) return;
  // recursive case
  printNodesRecursively(node.next);
// prints after base case is reached
  print(node.value);
}

void printListInReverse<E>(LinkedList<E> list) {
  printNodesRecursively(list.head);
}


/// 2. Finding the middle Node value
Node<E>? getMiddle<E>(LinkedList<E> list) {
  var slow = list.head;
  var fast = list.head;

  // Iterating through the list with fast var moving twice as fast as slow var
  while (fast?.next != null) {
    fast = fast?.next?.next;
    slow = slow?.next;
  }
  // returns the slow var (i.e) the middle value)
  return slow;
}


extension RemovableLinkedList<E> on LinkedList {
  /// 3. Function to reverse a linkedList (created inside linkedList class)
  void reverse() {
    /// A. Using temporary List
    // final tempList = LinkedList<E>();
    // for (final value in this) {
    //   tempList.push(value);
    // }
    // head = tempList.head;
    // print(head);

    /// B. Manipulating the direction of the pointers (reverse direction)
    // assign head to tail of LinkedList
    tail = head;
    // references to keep track of traversal
    var previous = head;
    var current = head?.next;
    // since tail is head, value after it is now assigned null value
    previous?.next = null;
    // traversing through the linkedList till you get to null.
    while (current != null) {
      // reference to move to the next value after current
      final next = current.next;
      // next value after current points to previous (main reversal action)
      current.next = previous;
      // previous now points to current value
      previous = current;
      // current now points to the next value after current
      current = next;
    }
    // head is the new last item in the list
    head = previous;
    print(head);
  }

  /// 4. Remove all occurrences of a certain value
  void removeAll(E value) {
    // if the first element in the linkedList is the value you want to remove,
    // shift the pointer to the next value, till the value is different from
    // the value of head.
    while (head != null && head!.value == value) {
      head = head!.next;
    }
    // pointers to traverse through the linkedList
    var previous = head;
    var current = head?.next;
    while (current != null) {
      // if the value to be removed is found, move the link to the value of
      // the element after the current value.(i.e head.next.next)
      if (current.value == value) {
        previous?.next = current.next;
        // current becomes the new linked value. (i.e head.next.next)
        current = previous?.next;
        // repeat the process for cases where the value reoccurs simultaneously
        continue;
      }
      // move the pointers one step forward in the linkedList
      previous = current;
      current = current.next;
    }
    //
    tail = previous;
  }
}