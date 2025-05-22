
import 'dart:math' as math;

// in main()
// final value = leafNodes(tree.root!.height);
//   print(value);

/// 1. Number of Leaves in a perfectly balanced tree
int numberOfLeafNodes(int height) {
  return math.pow(2, height).toInt();
}

/// 2. Number of Nodes in a perfectly balanced tree
int numberOfNodes(int height) {
  return math.pow(2, height + 1).toInt() - 1;
}

/// 3. Tree Traversal Interface
// Interface where all types of binary trees can implement/extend the traversal
// methods.
abstract class TraversableBinaryNode<T> {
  T get value;
  TraversableBinaryNode<T>? get leftChild;
  TraversableBinaryNode<T>? get rightChild;

  void traverseInOrder(void Function(T value) action) {
    leftChild?.traverseInOrder(action);
    action(value);
    rightChild?.traverseInOrder(action);
  }

  void traversePreOrder(void Function(T value) action) {
    action(value);
    leftChild?.traversePreOrder(action);
    rightChild?.traversePreOrder(action);
  }

  void traversePostOrder(void Function(T value) action) {
    leftChild?.traversePostOrder(action);
    rightChild?.traversePostOrder(action);
    action(value);
  }
}