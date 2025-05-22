
import '../../queues/queue_implementation.dart';

class TreeNode<T> {
  TreeNode(this.value);
  T value;
  List<TreeNode<T>> children = [];

  @override
  String toString() {
    for(int i = 0; i < children.length; i++){
      if(children.isEmpty) {
        print("$value");
      }
      String val = "$value \n${children[i].value}";
      print(val);
    }
    return "";
  }

  // add Child to the Parent
  void add(TreeNode<T> child) {
    children.add(child);
  }

  // Depth-First Traversal (recursive)
  void forEachDepthFirst(void Function(TreeNode<T> node) performAction) {
    // perform action on root node
    performAction(this);
    // iterate through the children of the root node
    for (final child in children) {
      // perform recursive action on each child node till you reach the leaf node
      child.forEachDepthFirst(performAction);
    }
  }

  // Level-Order Traversal
  void forEachLevelOrder(void Function(TreeNode<T> node) performAction) {
    final queue = QueueStack<TreeNode<T>>();
    // enqueue and perform action on root node (level 0)
    performAction(this);
    // enqueue items from level down (1) to the queue
    children.forEach(queue.enqueue);
    var node = queue.dequeue();
    // iterate through the enqueued items by dequeue till its null
    while (node != null) {
      // perform action on level 1
      performAction(node);
      // enqueue the items from the next level down into the dequeued items in
      // previous level
      node.children.forEach(queue.enqueue);
      // set new node value to next item in queue
      node = queue.dequeue();
    }
  }

  // Search for a value in Tree (using level order)
  TreeNode<T>? search(T value) {
    TreeNode<T>? result;
    forEachLevelOrder((node) {
      if (node.value == value) {
        result = node;
      }
    });
    return result;
  }
}