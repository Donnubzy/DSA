
class Node<T>{
  Node({required this.value, this.next});
  T value;
  Node<T>? next;

  @override
  String toString(){
    if(next == null) return value.toString();
    return "$value -> ${next.toString()}";
  }
}

class LinkedList<E> extends Iterable<E>{
  Node<E>? head;
  Node<E>? tail;

  @override
  bool get isEmpty => head == null;

  @override
  String toString(){
    if(isEmpty) return "Empty List";
    return head.toString();
  }

  void push(E value){
    head = Node(value: value, next: head);
    tail ??= head;
  }

  void append(E value){
    if(isEmpty){
      push(value);
      return;
    }
    tail!.next = Node(value: value);
    tail = tail!.next;
  }

  Node<E>? nodeAt(int index){
    Node<E>? currentNode = head;
    int currentIndex = 0;
    while(currentNode != null && currentIndex < index){
      currentNode = currentNode.next;
      currentIndex += 1;
    }
    return currentNode;
  }

  Node<E> insertAfter(Node<E> node, E value){
    if(tail == node){
      append(value);
      return tail!;
    }
    node.next = Node(value: value, next: node.next);
    return node.next!;
  }

  E? pop(){
    E? value = head?.value;
    head = head?.next;
    if(isEmpty){
      tail = null;
    }
    return value;
  }

  E? removeLast(){
    if(head?.next == null) return pop();
    Node<E>? current = head;
    while(current!.next != tail){
      current = current.next;
    }
    E? value = tail!.value;
    tail = current;
    tail!.next = null;
    return value;
  }

  E? removeAfter(Node<E> node){
    E? value = node.next?.value;
    if(node.next == tail){
      tail = node;
    }
    node.next = node.next?.next;
    return value;
  }

  @override
  Iterator<E> get iterator => LinkedListIterator(this);
}

class LinkedListIterator<E> implements Iterator<E>{
  LinkedListIterator(LinkedList<E> list) : _list = list;
  final LinkedList<E> _list;

  Node<E>? _currentNode;
  bool _firstPass = true;

  @override
  E get current => _currentNode!.value;

  @override
  bool moveNext(){
    if(_list.isEmpty) return false;
    if(_firstPass){
      _currentNode = _list.head;
      _firstPass = false;
    }
    else{
      _currentNode = _currentNode?.next;
    }
    return _currentNode != null;
  }
}