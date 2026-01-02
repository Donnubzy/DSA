
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
class FixedListStack<E>{
  FixedListStack(this.cap) : top = -1, arr = List.filled(cap, 0);
  int cap, top;
  List<int> arr;

  void push(int x) => top >= cap - 1 ? print("Stack Error") : arr[++top] = x;
  int pop() => top < 0 ? 0 : arr[top--];
  int get peek => top < 0 ? 0 : arr[top];
  int get size => arr.length;
  bool get isEmpty => arr.isEmpty;
  bool get isNotEmpty => !isEmpty;
}

/// Linked List
class Node {
  Node(int new_data) : this.data = new_data , this.next = null;
  int data;
  Node? next;
}

// Class to implement stack using a singly linked list
class LinkedListStack{
  LinkedListStack() : this.head = null;
  Node? head;

  bool get isEmpty => head == null;

  void push(int new_data) {
    // Create a new node with given data
    Node new_node = Node(new_data);
    // Check if memory allocation for the new node failed (if cap is set)
    if (new_node == null) {
      print("\nStack Overflow");
      return;
    }
    // Link the new node to the current top node
    new_node.next = head;
    // Update the top to the new node
    head = new_node;
  }

  void pop() {
    if (isEmpty) {
      print("\nStack Underflow");
    }
    else {
      // Assign the current top to a temporary node
      Node? temp = head!;
      // Update the top to the next node
      head = head!.next;
      // Deallocate the memory of the old top node
      temp = null;
    }
  }

  int peek() {
    // If stack is not empty, return the top element
    if (!isEmpty)
      return head!.data;
    else {
      print("\nStack is empty");
      return 0;
    }
  }
}